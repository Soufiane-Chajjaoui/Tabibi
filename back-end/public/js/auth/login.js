const Form = document.getElementById('FormLogin');
Form.addEventListener('submit', async (e)=>{
    e.preventDefault();
    showSpinner();
    var mail = document.getElementById('email').value ;
    var pwd = document.getElementById('password').value ;  
    console.log(mail , pwd)
     const res = await fetch('/admin/login' ,{
        headers: {'Content-Type': 'application/json'},
        method: 'POST' ,
        body: JSON.stringify({
            email : mail.trim() ,
            password : pwd.trim()
        })
    });
    const response = await res.json();
     console.log(response.admin);
    if (response.admin) {
         location.assign('/admin/dashboard');
    } else {
        setTimeout(() => {
             hideSpinner()  
        }, 500);
   
        for(const [key , value] of Object.entries(response.err)) {
        if (value.length > 0) {
            showAlert(value);
        }
        
        }
    }
   
})

function showSpinner() {
    const spinnerContainer = document.getElementById("spinnerContainer");
    spinnerContainer.style.display = "flex";
  }


function hideSpinner() {
  const spinnerContainer = document.getElementById("spinnerContainer");
  setTimeout(() => {
    spinnerContainer.style.display = "none";
  }, 300);
}


function showAlert(message) {
const alert = document.createElement("div");
alert.className = "alert alert-danger";
alert.style.zIndex = "2";
const icon = document.createElement("i");
icon.className = "fas fa-exclamation-circle"; // Replace with the desired alert icon class

const closeButton = document.createElement("button");
closeButton.className = "btn-close ms-2";
closeButton.style.float = "right"; // Align the close button to the right

const content = document.createElement("span");
content.textContent = message;
content.style.marginLeft = "8px"; // Adjust the desired amount of space using CSS

alert.appendChild(icon);
alert.appendChild(content);
alert.appendChild(closeButton);

const container = document.getElementById("alertContainer");
container.insertBefore(alert, container.firstChild);
setTimeout(function() {
        alert.remove();
      }, 4000); // Remove the alert after the transition completes (300 milliseconds)
      
// // Scroll to the top of the page
// window.scrollTo({
// top: 0,
// behavior: 'smooth' // Use 'smooth' for smooth scrolling, or 'auto' for instant scrolling
// });


  // Automatically hide the alert after 3 seconds (3000 milliseconds)
  closeButton.addEventListener("click", function() {
      alert.style.opacity = 0.4; // Set the opacity to 0 for a fade-out effect
      setTimeout(function() {
        alert.remove();
      }, 300); // Remove the alert after the transition completes (300 milliseconds)
   });


}

Form_validation = ()=>{
    var mail = document.getElementById('email').value.trim() ;
    var pwd = document.getElementById('password').value.trim() ;  
    var element = document.getElementById('checkEmail') ;
    var pwd_element = document.getElementById('checkPwd') ;

    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            hideSpinner();
      if (mail == ''  ||  pwd == '' ) {
         if (mail == '') {
          element.innerHTML = "**Email is required champ";  
         }else   {
          pwd_element.innerHTML = '**Email is required champ'
        }    
          return false
     }else  {
        if (!emailPattern.test(mail)) {
            element.innerHTML = "**Email is not valid";
           return false;
        }else{
        element.innerHTML = '';
        pwd_element.innerHTML = '' ;
         return true
        }
     }  
}