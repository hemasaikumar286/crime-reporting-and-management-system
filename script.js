// ============================
// GLOBAL ALERT FUNCTION
// ============================
function showAlert(message, type = "success") {
    const alertBox = document.createElement("div");
    alertBox.innerText = message;
    alertBox.className = "alert " + type;
    document.body.appendChild(alertBox);

    setTimeout(() => {
        alertBox.remove();
    }, 3000);
}

// ============================
// LOGIN VALIDATION
// ============================
function validateLogin() {
    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();

    if (username === "" || password === "") {
        showAlert("Please enter username and password", "error");
        return false;
    }

    showAlert("Login Successful");
    return true;
}

// ============================
// CRIME REPORT FORM VALIDATION
// ============================
function validateCrimeForm() {
    const crimeType = document.getElementById("crimeType").value;
    const description = document.getElementById("description").value.trim();
    const location = document.getElementById("location").value.trim();

    if (crimeType === "") {
        showAlert("Select crime type", "error");
        return false;
    }

    if (description.length < 10) {
        showAlert("Description must be at least 10 characters", "error");
        return false;
    }

    if (location === "") {
        showAlert("Enter incident location", "error");
        return false;
    }

    showAlert("Crime Report Submitted Successfully");
    return true;
}

// ============================
// CASE STATUS CHECK
// ============================
function checkCaseStatus() {
    const caseId = document.getElementById("caseId").value.trim();
    const result = document.getElementById("statusResult");

    if (caseId === "") {
        showAlert("Enter Case ID", "error");
        return;
    }

    // Demo statuses (replace with backend API later)
    const statuses = ["New", "Assigned", "In Investigation", "Closed"];
    const randomStatus = statuses[Math.floor(Math.random() * statuses.length)];

    result.innerText = "Case Status: " + randomStatus;
}

// ============================
// DASHBOARD COUNTER ANIMATION
// ============================
function animateCounter(id, endValue) {
    let current = 0;
    const element = document.getElementById(id);
    const interval = setInterval(() => {
        current++;
        element.innerText = current;
        if (current >= endValue) {
            clearInterval(interval);
        }
    }, 30);
}

// ============================
// FILE UPLOAD CHECK
// ============================
function validateFile(inputId) {
    const fileInput = document.getElementById(inputId);
    const file = fileInput.files[0];

    if (!file) return;

    const allowedTypes = ["image/jpeg", "image/png", "video/mp4", "audio/mp3"];
    if (!allowedTypes.includes(file.type)) {
        showAlert("Invalid file type!", "error");
        fileInput.value = "";
    }
}

// ============================
// SEARCH FILTER (TABLE)
// ============================
function filterTable(inputId, tableId) {
    const input = document.getElementById(inputId).value.toLowerCase();
    const rows = document.querySelectorAll(`#${tableId} tbody tr`);

    rows.forEach(row => {
        const text = row.innerText.toLowerCase();
        row.style.display = text.includes(input) ? "" : "none";
    });
}

// ============================
// ON PAGE LOAD
// ============================
window.onload = function () {
    if (document.getElementById("totalCases")) {
        animateCounter("totalCases", 120);
        animateCounter("openCases", 45);
        animateCounter("closedCases", 75);
    }
};
