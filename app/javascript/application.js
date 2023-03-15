// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// const deleteButtons = document.querySelectorAll('.button');
// deleteButtons.forEach(button => {
//     button.addEventListener('click', async (e) => {
//         console.log("We clicked")
//         e.preventDefault();
//         const confirm = window.confirm("Are you sure you want to delete?")
//         if(!confirm){
//           return
//         }
//         // disable the button
//         button.disabled = true;
//        const response = await axios.delete(button.parentElement.action, {
//         headers: {
//             'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
//             'Content-Type':  'application/json',
//        } })
//        if(response.status === 200) {
//            button.parentElement.parentElement.parentElement.remove()
//            const notice = document.querySelector('.notice')
//               notice.innerHTML = "Delete successful"
//        } else{
//          const error = document.querySelector('.alert')
//          // remove the disabled attribute
//             button.removeAttribute('disabled')
//         error.innerHTML = "Delete failed"
//        }


//     })
// })
