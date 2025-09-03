/* TODO: inserire il bottone
//Get the button:
mybutton = document.getElementById("cruscotto");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0; // For Safari
  document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
}
*/

function aload (page) {
  fetch(page)
    .then(res => res.text())
    .then(txt => document.getElementById("container").outerHTML = txt);
}

    // Get the element
    var element = document.getElementById("my-calendar");
    // Create the calendar
    var myCalendar = jsCalendar.new(element);
    // Get the inputs
    var inputA = document.getElementById("my-input-a");
    // Add events
    myCalendar.onDateClick(function(event, date){
        inputA.value = 'htdocs/' + date.getFullYear() + '/' + ("0" + date.getFullYear()).slice(-2) + ("0" + (date.getMonth()+1)).slice(-2) + ("0" + date.getDate()).slice(-2) + '.html';
        fetch(inputA.value)
          .then((response) => {
            if (response.ok) {
              aload(inputA.value)
		} else {
			aload('home.html');
		}
		scroll(0,0);
        })
        .catch((error) => {
          console.log('There was an error with the request')
        })
    });

// apro bastabugie in una nuova finestra
document.addEventListener("click", function (e) {
  if (e.target.tagName == "A" && !e.target.hasAttribute("target")) {
    e.target.setAttribute("target", "_blank");
  }
});
