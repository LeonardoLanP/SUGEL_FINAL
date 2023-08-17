  // todas las clases de materia
    var materias = document.getElementsByClassName('materia');

 
    for (var i = 0; i < materias.length; i++) {
      // Agrega el evento de doble clic a cada clase de materia
      materias[i].addEventListener('dblclick', function() {
        var materia = this;

      
        var confirmOverlay = document.createElement('div');
        confirmOverlay.classList.add('confirm-overlay');

        var confirmModal = document.createElement('div');
        confirmModal.classList.add('confirm-modal');
        confirmModal.innerHTML = `
          <h2>¿Estás seguro de que quieres eliminar esta materia?</h2>
          <button id="confirm-yes">Sí</button>
          <button id="confirm-no">No</button>
        `;

        confirmOverlay.appendChild(confirmModal);
        document.body.appendChild(confirmOverlay);

       
        var confirmYesBtn = document.getElementById('confirm-yes');
        confirmYesBtn.addEventListener('click', function() {
          // Elimina la materia si el usuario confirma
          materia.parentNode.removeChild(materia);
          confirmOverlay.remove();
        });

 
        var confirmNoBtn = document.getElementById('confirm-no');
        confirmNoBtn.addEventListener('click', function() {
          // Cierra la ventana emergente si el usuario cancela
          confirmOverlay.remove();
        });
      });
    }




