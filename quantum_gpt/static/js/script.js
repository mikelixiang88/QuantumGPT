let questionCount = 0;

function askQuestion() {
    const userInput = document.getElementById("user-input").value;
    const chatOutput = document.getElementById("chat-output");

    // Update session information
    questionCount++;
    document.getElementById("question-count").textContent = questionCount;
    const currentTime = new Date().toLocaleTimeString();
    document.getElementById("last-question-time").textContent = currentTime;

    // Simulate API call (Replace this with actual API call)
    setTimeout(() => {
        const apiResponse = "This is a simulated answer from Quantum GPT.";
        
        chatOutput.innerHTML += `<div class="user-message">${userInput}</div>`;
        chatOutput.innerHTML += `<div class="bot-message">${apiResponse}</div>`;
    }, 1000);
}
