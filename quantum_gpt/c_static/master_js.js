function getCookie(name) {
    let value = "; " + document.cookie;
    let parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
}

function editTeleporter() {
    // Send the updated teleporter to the server
    fetch('/update_teleporter/', {
        method: 'POST',
        body: new URLSearchParams({
            'teleporter': 'The teleporter is empty',
        }),
        headers: {
            'X-Requested-With': 'XMLHttpRequest',  // Necessary to work with Django
            'X-CSRFToken': getCookie('csrftoken')  // For CSRF protection in Django
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            let teleporter = data.teleporter;;
            document.getElementById('editableTeleporter').value = teleporter;
            document.getElementById('teleporterText').style.display = 'none';
            document.getElementById('editableTeleporter').style.display = 'block';
            document.querySelector('.edit-teleporter').style.display = 'none';
            document.querySelector('.save-teleporter').style.display = 'block';

        } else {
            alert('Error updating teleporter.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

function saveTeleporter() {
    const teleporter = document.getElementById('editableTeleporter').value;
    // Send the updated teleporter to the server
    fetch('/update_teleporter/', {
        method: 'POST',
        body: new URLSearchParams({
            'teleporter': teleporter,
        }),
        headers: {
            'X-Requested-With': 'XMLHttpRequest',  // Necessary to work with Django
            'X-CSRFToken': getCookie('csrftoken')  // For CSRF protection in Django
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Teleportation completed, and another user can see your message! Due to no cloning theorem, you are not able to see your message here. ');
            document.getElementById('teleporterText').style.display = 'block';
            document.getElementById('editableTeleporter').style.display = 'none';
            document.querySelector('.edit-teleporter').style.display = 'block';
            document.querySelector('.save-teleporter').style.display = 'none';
        } else {
            alert('Error updating teleporter.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

function askQuestion() {
    const username = "{{ request.user.username }}";
    let question = document.querySelector('textarea').value;

    let modelType = null;
    document.querySelectorAll('.session-button').forEach(button => {
        if (button.classList.contains('active')) {
            modelType = button.id;
        }
    });
    if (question) {
        // Send the question to the Django backend
        fetch('/ask_question/', {
            method: 'POST',
            body:  new URLSearchParams({
                'question': question,
                'modelType': modelType // Include the selected button id
            }),
            headers: {
                'X-Requested-With': 'XMLHttpRequest',  // Necessary to work with Django
                'X-CSRFToken': getCookie('csrftoken')  // For CSRF protection in Django
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                // Display the error message to the user
                alert(data.error);
            }else{
                let responseContainer = document.querySelector('.response-container');
                responseContainer.innerHTML += `
                <div class="response-section" data-model-type="${modelType}">
                    <p class="question-text"> <strong>${username}:</strong> ${question}</p>
                    <p class="response-text"> <strong>QuantumGPT:</strong> ${data.response}</p>
                    <button class="comment-btn" onclick="showCommentForm(this)">Comment</button>
                </div>
                <hr>`;
                document.getElementById('questionsLeftElement').innerHTML = `<strong>Question Token:</strong> ${data.question_left}`;
                document.getElementById('questionsAskedElement').innerHTML = `<strong>Question Asked:</strong> ${data.question_asked}`;
                document.querySelector('textarea').value = ''; // Clear the textarea
                responseContainer.scrollTop = responseContainer.scrollHeight; // Scroll to the most recent response
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
}



function clearResponse() {
    document.querySelector('.response-container').innerHTML = `<h2>Response</h2>`;
}


function addSession() {
    const sessionList = document.querySelector('.session-list');
    const newSession = document.createElement('li');
    newSession.textContent = `Session ${sessionList.children.length + 1}`;
    newSession.onclick = function() {
        selectSession(newSession);
    };
    sessionList.appendChild(newSession);
    selectSession(newSession);
}

function selectSession(sessionElement) {
    const sessionListItems = document.querySelectorAll('.session-list li');
    sessionListItems.forEach(item => item.classList.remove('active'));
    sessionElement.classList.add('active');
    currentSession = sessionElement.textContent;
    document.querySelector('.response-container').innerHTML = `<h2>Response for ${currentSession}</h2>`;
}

function showCommentForm(buttonElement) {
    const commentForm = `
        <label>
            <input type="radio" name="answer" value="correct"> Correct
        </label>
        <br>
        <label>
            <input type="radio" name="answer" value="partial_correct"> Partially Correct
        </label>
        <br>
        <label>
            <input type="radio" name="answer" value="incorrect"> Incorrect
        </label>
        <br>
        <label>
            <input type="radio" name="answer" value="doubts"> Have Doubts
        </label>
        <textarea class="comment-text" placeholder="Min 20 characters"></textarea>
        <button onclick="submitComment(this)">Submit</button>
        <button onclick="cancelComment(this)">Cancel</button>
    `;

    // Replace the "Comment" button with the comment form
    buttonElement.outerHTML = commentForm;
}

function cancelComment(buttonElement) {
    const responseText = buttonElement.parentElement.querySelector('.response-text').innerHTML;
    const questionText = buttonElement.parentElement.querySelector('.question-text').innerHTML;
    const commentSection = `
        <p class="question-text"> ${questionText}</p>
        <p class="response-text">${responseText}</p>
        <button class="comment-btn" onclick="showCommentForm(this)">Comment</button>
    `;

    buttonElement.parentElement.innerHTML = commentSection;
}



function submitComment(buttonElement) {
    const user_id = "{{ request.user.id }}"; // Dynamically get the user_id
    const username= "{{ request.user.username }}";
    const responseText = buttonElement.parentElement.querySelector('.response-text').textContent.slice(13);
    const responseElement = buttonElement.parentElement.querySelector('.response-text').innerHTML;
    const questionText = buttonElement.parentElement.querySelector('.question-text').textContent.slice(username.length+3);
    const questionElement = buttonElement.parentElement.querySelector('.question-text').innerHTML;
    const commentText = buttonElement.previousElementSibling.value;
    
    const selectedRadioButton = buttonElement.parentElement.querySelector('input[name="answer"]:checked');
    const correctness = selectedRadioButton ? selectedRadioButton.value : null;

    const responseSection = buttonElement.parentElement;
    const modelType = responseSection.dataset.modelType;

    if (!correctness) {
        alert('Please select an answer.');
        return;
    }

    if (commentText.length >= 20) {
        fetch('/submit_comment/', {
            method: 'POST',
            body: new URLSearchParams({
                'question': questionText,
                'response': responseText,
                'comment': commentText,
                'correctness': correctness,
                'user_id': user_id,
                'modelType': modelType
            }),
            headers: {
                'X-Requested-With': 'XMLHttpRequest',
                'X-CSRFToken': getCookie('csrftoken')
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Comment submitted successfully!");
                // Hide the comment form and show the "Comment" button again
                const commentSection = `
                    <p class="question-text">${questionElement}</p>
                    <p class="response-text">${responseElement}</p>
                    <button class="comment-btn" onclick="showCommentForm(this)">Comment</button>
                `;
                buttonElement.parentElement.innerHTML = commentSection;
                document.getElementById('questionsLeftElement').innerHTML = `<strong>Question Token:</strong> ${data.question_left}`;
                document.getElementById('commentsMadeElement').innerHTML = `<strong>Comments Made:</strong> ${data.comments_made}`;
            } else {
                alert("Error submitting comment.");
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    } else {
        alert("Please enter a comment with at least 20 characters.");
    }
}

function selectButton(buttonId) {
    // Deselect all buttons
    document.querySelectorAll('.session-button').forEach(button => {
        button.classList.remove('active');
    });

    // Select the clicked button
    document.getElementById(buttonId).classList.add('active');

}


function postComment() {
    var commentText = document.getElementById('commentText').value;

    // Basic validation
    if(commentText.length < 20) {
        alert('Comment must be at least 20 characters long.');
        return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open('POST', '{% url "add_comment" post.id %}', true);
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.setRequestHeader('X-CSRFToken', '{{ csrf_token }}');

    xhr.onload = function () {
        if (xhr.status === 200) {
            alert('Comment added successfully!');
            location.reload(); // Reload the page to display the new comment
        } else {
            alert('Error adding comment: ' + xhr.responseText);
        }
    };

    xhr.send('comment=' + encodeURIComponent(commentText));
}


function postcomment() {
    const content = document.querySelector('textarea').value;

    // Check if the comment is less than 20 characters
    if (content.length < 20) {
        alert("Your comment must be at least 20 characters long.");
        return;
    }

    const topicId = {{ comment_id }};  // Assuming you passed the topic instance to the template
    const url = `/api/topic/${topicId}/post_comment/`;

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-CSRFToken': getCookie('csrftoken')
        },
        body: `content=${content}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "success") {
            alert(data.message);
            location.reload();  // Reload the page to display the new comment
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert("An error occurred. Please try again.");
    });
}

function selectUser(users, message) {
    return new Promise((resolve, reject) => {
        // Get the operation div
        let operationDiv = document.getElementById('operation');
        operationDiv.innerHTML = ''; // Clear previous content

        // Create a title or message
        let title = document.createElement('h2');
        title.innerText = message;
        operationDiv.appendChild(title);

        // Create a list of users with checkboxes
        users.forEach(user => {
            let checkbox = document.createElement('input');
            checkbox.type = 'checkbox';
            checkbox.id = `user_${user.id}`;
            checkbox.value = user.id;

            let label = document.createElement('label');
            label.htmlFor = `user_${user.id}`;
            label.innerText = user.username;

            operationDiv.appendChild(checkbox);
            operationDiv.appendChild(label);
            operationDiv.appendChild(document.createElement('br'));
        });

        // Create a submit button
        let submitButton = document.createElement('button');
        submitButton.innerText = 'Submit';
        submitButton.onclick = () => {
            let selectedUsers = [];
            users.forEach(user => {
                if (document.getElementById(`user_${user.id}`).checked) {
                    selectedUsers.push(user);
                }
            });
            resolve(selectedUsers);
            operationDiv.innerHTML='';
            // Create buttons
            const addButton = document.createElement('button');
            addButton.textContent = 'Add Participants';
            addButton.addEventListener('click', function () {
                addParticipants(currentSessionId);
            });

            const leaveButton = document.createElement('button');
            leaveButton.textContent = 'Leave';
            leaveButton.addEventListener('click', function () {
                leaveChat(currentSessionId, is_owner);
            });

            const viewP = document.createElement('button');
            viewP.textContent = 'View Participant';
            viewP.addEventListener('click', function () {
                viewParticipants(currentSessionId);
            });

            // Append buttons to the parent element
            const row1 = document.createElement('div');
            operationDiv.appendChild(row1);
            row1.appendChild(addButton);
            row1.appendChild(leaveButton);
            row1.appendChild(viewP);

            // Check if the user is an owner and add more buttons accordingly
            if (is_owner) {
                const transferButton = document.createElement('button');
                transferButton.textContent = 'Transfer';
                transferButton.addEventListener('click', function() {
                    transferOwnership(currentSessionId);
                });

                const removeButton = document.createElement('button');
                removeButton.textContent = 'Remove Participant';
                removeButton.addEventListener('click', function() {
                    removeParticipants(currentSessionId);
                });

                const changetitleButton = document.createElement('button');
                changetitleButton.textContent = 'Change Title';
                changetitleButton.addEventListener('click', function() {
                    changeName(currentSessionId);
                });

                const row2 = document.createElement('div');
                operationDiv.appendChild(row2);
                row2.appendChild(transferButton);
                row2.appendChild(removeButton);
                row2.appendChild(changetitleButton);
            }

        };
        operationDiv.appendChild(submitButton);

        // Create a cancel button
        let cancelButton = document.createElement('button');
        cancelButton.innerText = 'Cancel';
        cancelButton.onclick = () => {
            reject('User selection was cancelled.');
            // Create buttons
            operationDiv.innerHTML='';
            // Create buttons
            const addButton = document.createElement('button');
            addButton.textContent = 'Add Participants';
            addButton.addEventListener('click', function () {
                addParticipants(currentSessionId);
            });

            const leaveButton = document.createElement('button');
            leaveButton.textContent = 'Leave';
            leaveButton.addEventListener('click', function () {
                leaveChat(currentSessionId, is_owner);
            });

            const viewP = document.createElement('button');
            viewP.textContent = 'View Participant';
            viewP.addEventListener('click', function () {
                viewParticipants(currentSessionId);
            });

            // Append buttons to the parent element
            const row1 = document.createElement('div');
            operationDiv.appendChild(row1);
            row1.appendChild(addButton);
            row1.appendChild(leaveButton);
            row1.appendChild(viewP);

            // Check if the user is an owner and add more buttons accordingly
            if (is_owner) {
                const transferButton = document.createElement('button');
                transferButton.textContent = 'Transfer';
                transferButton.addEventListener('click', function() {
                    transferOwnership(currentSessionId);
                });

                const removeButton = document.createElement('button');
                removeButton.textContent = 'Remove Participant';
                removeButton.addEventListener('click', function() {
                    removeParticipants(currentSessionId);
                });

                const changetitleButton = document.createElement('button');
                changetitleButton.textContent = 'Change Title';
                changetitleButton.addEventListener('click', function() {
                    changeName(currentSessionId);
                });

                const row2 = document.createElement('div');
                operationDiv.appendChild(row2);
                row2.appendChild(transferButton);
                row2.appendChild(removeButton);
                row2.appendChild(changetitleButton);
            } 
            
        };
        operationDiv.appendChild(cancelButton);
    });
}


function loadChatSessions(sessionId) {
    // Load chat sessions from the server and display them in the chat session list
    fetch('/chat_sessions/')
        .then(response => response.json())
        .then(data => {
            const sessions = data.chat_sessions; // Extract chat_sessions from the data
            const sessionList = document.getElementById('chatSessionList');
            sessionList.innerHTML = '';


            // If sessionId is provided, find and move it to the top of the sessions array
            if (sessionId !== undefined) {
                // Check if sessionId exists in the array
                const sessionExists = sessions.some(session => session.id === sessionId);

                if (!sessionExists) {
                    // If sessionId does not exist, exit the function early
                    return;
                }
                const sessionIndex = sessions.findIndex(session => session.id === sessionId);
                if (sessionIndex !== -1) {
                    const [selectedSession] = sessions.splice(sessionIndex, 1);
                    sessions.unshift(selectedSession);
                }
            }

            sessions.forEach(session => {
                const button = document.createElement('button');
                
                // You can customize this part to display the information you prefer
                button.textContent = `${session.title}`;
                button.className = 'session-button';
                
                button.onclick = function () {
                    openChatSession(session.id, session.title);
                };
                sessionList.appendChild(button);
            });
        })
        .catch(error => {
            console.error('Error loading chat sessions:', error);
        });
}


function openChatSession(sessionId, chatTitle) {
    // Bind to a Pusher event when a new message is triggered for this session
    if (currentChannel) {
        currentChannel.unbind("new-message");
        currentChannel.unbind("participant-removed"); // Update event name
        pusher.unsubscribe(currentChannel.name);
    }

    // Subscribe to the new channel with the same naming convention as in the backend
    currentChannel = pusher.subscribe(`presence-chat-${sessionId}`); // Use presence channel

    // Bind to a Pusher event when a new message is triggered for this session
    currentChannel.bind("new-message", function (data) {
        if (!displayedMessageIds.includes(data.message_id)) {
            // If not, add it to the list and display the message
            displayedMessageIds.push(data.message_id);

            // Access the username and message content from the event data
            const username = data.username;
            const content = data.message.content;
            const userID = data.userID;

            // Display the message with the username
            const usernameLink = document.createElement('a');
            usernameLink.textContent = `${username}`;
            usernameLink.href = `/displayuserID/${userID}`;
            const messageSpan = document.createElement('span');
            messageSpan.appendChild(usernameLink);
            messageSpan.appendChild(document.createTextNode(`: ${content}`));
            const messageContainer = document.getElementById('chatMessages');
            const p = document.createElement('p');
            p.appendChild(messageSpan);
            messageContainer.appendChild(p);
            messageContainer.scrollTop = messageContainer.scrollHeight;
        }
    });

    // Bind to an event that listens for when a user is removed from the chat
    currentChannel.bind("participant-removed", function (data) {
        if (data.removedUserId === {{ request.user.id }}) {
            // The current user has been removed from the chat, so unsubscribe
            alert(data.message); // Alert the user they've been removed
            pusher.unsubscribe(`presence-chat-${sessionId}`);
        }
    });

    let titleDiv = document.getElementById('chatTitle');
    titleDiv.innerHTML = `${chatTitle}`;

    // Load and display messages for the specified chat session
    currentSessionId = sessionId;
    let operationDiv = document.getElementById('operation');
    operationDiv.innerHTML = '';

    // Create buttons
    const addButton = document.createElement('button');
    addButton.textContent = 'Add Participants';
    addButton.addEventListener('click', function () {
        addParticipants(sessionId);
    });

    const leaveButton = document.createElement('button');
    leaveButton.textContent = 'Leave';
    leaveButton.addEventListener('click', function () {
        leaveChat(sessionId, is_owner);
    });

    const viewP = document.createElement('button');
    viewP.textContent = 'View Participant';
    viewP.addEventListener('click', function () {
        viewParticipants(sessionId);
    });

    // Append buttons to the parent element
    const row1 = document.createElement('div');
    operationDiv.appendChild(row1);
    row1.appendChild(addButton);
    row1.appendChild(leaveButton);
    row1.appendChild(viewP);

    fetch(`/open_chat/${sessionId}/messages/`, {
        method: 'GET',
        headers: {
            'X-CSRFToken': getCookie('csrftoken'), // Include CSRF token
        },
    })
        .then(response => response.json())
        .then(data => {
            if (data.owner === {{ request.user.id }}) {
                is_owner = true;
            } else {
                is_owner = false;
            }
            // Check if the user is an owner and add more buttons accordingly
            if (is_owner) {
                const transferButton = document.createElement('button');
                transferButton.textContent = 'Transfer';
                transferButton.addEventListener('click', function () {
                    transferOwnership(sessionId);
                });

                const removeButton = document.createElement('button');
                removeButton.textContent = 'Remove Participant';
                removeButton.addEventListener('click', function () {
                    removeParticipants(sessionId);
                });

                const changetitleButton = document.createElement('button');
                changetitleButton.textContent = 'Change Title';
                changetitleButton.addEventListener('click', function () {
                    changeName(sessionId);
                });

                const row2 = document.createElement('div');
                operationDiv.appendChild(row2);
                row2.appendChild(transferButton);
                row2.appendChild(removeButton);
                row2.appendChild(changetitleButton);
            }
            if (Array.isArray(data.messages)) {
                const messageContainer = document.getElementById('chatMessages');
                messageContainer.innerHTML = '';
                data.messages.forEach(message => {
                    const username = message.sender;
                    const content = message.content;
                    const userID = message.senderID;

                    // Display the message with the username
                    const usernameLink = document.createElement('a');
                    usernameLink.textContent = `${username}`;
                    usernameLink.href = `/displayuserID/${userID}`;
                    const messageSpan = document.createElement('span');
                    messageSpan.appendChild(usernameLink);
                    messageSpan.appendChild(document.createTextNode(`: ${content}`));
                    const messageContainer = document.getElementById('chatMessages');
                    const p = document.createElement('p');
                    p.appendChild(messageSpan);
                    messageContainer.appendChild(p);
                    messageContainer.scrollTop = messageContainer.scrollHeight;
                });
            } else {
                console.error('API response does not contain a valid messages array:', data);
            }
        })
        .catch(error => {
            console.error('Error fetching and processing messages:', error);
        });
}



function initiateChat(selectedUsers) {
    const cTitle = window.prompt('Enter chat title:');
    fetch('/init_chat/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCookie('csrftoken')
        },
        body: JSON.stringify({ participants: selectedUsers, title: cTitle })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Chat session initiated successfully!');
            location.reload();
        } else {
            alert('Failed to initiate chat session.');
        }
    })
    .catch(error => console.error('Error:', error));
}

function leaveChat(sessionId, isOwner) {
    if (isOwner && !confirm('Are you sure you want to leave? The chat session will be deleted.')) {
        return;
    }
    currentSessionId=null;

    fetch(`/chat/${sessionId}/leave/`, {
        method: 'POST',
        headers: {
            'X-CSRFToken': getCookie('csrftoken')
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Left the chat session successfully!');
            location.reload();
        } else {
            alert('Failed to leave the chat session.');
        }
    })
    .catch(error => console.error('Error:', error));
}

function addParticipants(sessionId) {
    // Fetch the followers and followed users
    fetch('/get_followed_and_followers/')
        .then(response => response.json())
        .then(data => {
            let users = data.followed.concat(data.followers);
            // Remove duplicates
            let uniqueUsers = [];
            let userIdsSet = new Set();
            users.forEach(user => {
                if (!userIdsSet.has(user.id)) {
                    userIdsSet.add(user.id);
                    uniqueUsers.push(user);
                }
            });

            // Fetch current participants
            return fetch(`/get_participants/${sessionId}`)
                .then(response => response.json())
                .then(participantData => {
                    let participants = participantData.participants.map(user => user.id);

                    // Remove existing participants from uniqueUsers
                    uniqueUsers = uniqueUsers.filter(user => !participants.includes(user.id));
                    
                    return uniqueUsers;
                });
        })
        .then(uniqueUsers => {
            selectUser(uniqueUsers, 'Select users to add to the chat')
                .then(selectedUsers => {
                    let userIds = selectedUsers.map(user => user.id);
                    fetch(`/chat/${sessionId}/add/`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRFToken': getCookie('csrftoken')
                        },
                        body: JSON.stringify({ participants: userIds })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Participants added to the chat!');
                            location.reload();
                        } else {
                            alert('Failed to add participants.');
                        }
                    })
                    .catch(error => console.error('Error:', error));
                })
                .catch(error => console.error('Error:', error));
        })
        .catch(error => console.error('Error:', error));
}



function removeParticipants(sessionId) {
    fetch(`/get_participants/${sessionId}`)
    .then(response => response.json())
    .then(data => {
        let participants = data.participants;
        // Filter out the current user from the list of participants
        participants = participants.filter(user => user.id !== {{ request.user.id }});
        selectUser(participants, 'Select users to remove from the chat')
            .then(selectedUsers => {
                let usersToRemove = selectedUsers.map(user => user.id);
                fetch(`/chat/${sessionId}/remove/`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRFToken': getCookie('csrftoken')
                    },
                    body: JSON.stringify({ participants: usersToRemove })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Participants removed!');
                        location.reload();
                    } else {
                        alert('Failed to remove participants.');
                    }
                })
                .catch(error => console.error('Error:', error));
            })
            .catch(error => console.error('Error:', error));
    })
    .catch(error => console.error('Error:', error));
}

function viewParticipants(sessionId){
    fetch(`/get_participants/${sessionId}`)
    .then(response => response.json())
    .then(data => {
        let participants = data.participants;
        let owner = data.owner;

        // Create a popup div
        let popup = document.createElement('div');
        popup.className = 'popup';
        document.body.appendChild(popup);

        // Create a heading for the owner
        let ownerHeading = document.createElement('h2');
        ownerHeading.textContent = 'Owner';
        popup.appendChild(ownerHeading);

        // Display the owner with a link to their profile
        let ownerLink = document.createElement('a');
        ownerLink.href = `/displayuserID/${owner.id}`;
        ownerLink.textContent = owner.username;
        popup.appendChild(ownerLink);

        // Create a heading for the participants
        let participantsHeading = document.createElement('h2');
        participantsHeading.textContent = 'Participants';
        popup.appendChild(participantsHeading);

        // Display each participant with a link to their profile
        participants.forEach(participant => {
            let participantLink = document.createElement('a');
            participantLink.href = `/displayuserID/${participant.id}`;
            participantLink.textContent = participant.username;
            popup.appendChild(participantLink);
            popup.appendChild(document.createElement('br'));  // Add a line break between participants
        });

        // Optional: Add a close button to the popup
        let closeButton = document.createElement('button');
        closeButton.textContent = 'Close';
        closeButton.onclick = function () {
            document.body.removeChild(popup);
        };
        popup.appendChild(closeButton);
    })
    .catch(error => console.error('Error:', error));
}

function changeName(sessionId) {
    const cTitle = window.prompt('Enter chat title:');
    fetch(`/chat/${sessionId}/changetitle/`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCookie('csrftoken')
        },
        body: JSON.stringify({ title: cTitle })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Title changed!');
            location.reload();
        } else {
            alert('Failed to change title.');
        }
    })
    .catch(error => console.error('Error:', error));
}

function transferOwnership(sessionId) {
    fetch(`/get_participants/${sessionId}`)
    .then(response => response.json())
    .then(data => {
        let participants = data.participants;
        // Filter out the current user from the list of participants
        participants = participants.filter(user => user.id !== {{ request.user.id }});
        selectUser(participants, 'Select users to transfer')
            .then(selectedUsers => {
                if (selectedUsers.length === 1) {
                let new_ownerID = selectedUsers[0].id;
                fetch(`/chat/${sessionId}/transfer_ownership/`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRFToken': getCookie('csrftoken')
                    },
                    body: JSON.stringify({ new_owner_id: new_ownerID })
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('Ownership transferred successfully!!');
                            location.reload();
                        } else {
                            alert('Failed to transfer ownership.');
                        }
                    })
                    .catch(error => console.error('Error:', error));
                } else {
                    alert('Please select exactly one user to transfer ownership.');
                }
            })
            .catch(error => console.error('Error:', error));
    })
    .catch(error => console.error('Error:', error));
}


function sendMessage() {
    const messageInput = document.getElementById('messageInput');
    const message = messageInput.value.trim();
    if (message === '') {
        alert('Message cannot be empty');
        return;
    }

    // Include the required fields in the JSON payload
    const payload = {
        chat_session: currentSessionId, // Replace with the actual chat session ID
        sender: {{ request.user.id }}, // Replace with the actual sender's ID
        content: message,
    };

    fetch(`/chat/${currentSessionId}/send_message/`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCookie('csrftoken')
        },
        body: JSON.stringify(payload) // Send the payload with required fields
    })
    .then(response => response.json())
    .then(data => {
        messageInput.value = ''; // Clear the input field
        let titleDiv = document.getElementById('chatTitle');
        title = titleDiv.innerHTML;
        openChatSession(currentSessionId, title); // Refresh the chat messages
    });
}




function uploadImage() {
    var fileInput = document.getElementById('imageInput');
    var file = fileInput.files[0];
    var formData = new FormData();
    formData.append('image', file);

    fetch('/upload_image/', {
        method: 'POST',
        body: formData,
        headers: {
            'X-CSRFToken': getCookie('csrftoken')
        }
    })
    .then(response => response.json())
    .then(data => {
        var imageUrl = data.imageUrl;
        var editorContent = CKEDITOR.instances.yourEditorInstance.getData();
        // Insert the image at the end of the content or at the cursor position
        CKEDITOR.instances.yourEditorInstance.setData(editorContent + '<img src="' + imageUrl + '" alt="Uploaded Image"/>');
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

function insertImageInEditor(imageUrl) {
    // Example: Inserting image at the end of CKEditor content
    var editorContent = CKEDITOR.instances.yourEditorInstance.getData();
    CKEDITOR.instances.yourEditorInstance.setData(editorContent + '<img src="' + imageUrl + '" alt="Uploaded Image"/>');
}

