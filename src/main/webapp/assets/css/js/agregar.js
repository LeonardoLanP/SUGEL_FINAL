var btnAbrir=document.getElementById('btn-abrir'),
	overlay=document.getElementById('overlay'),
	pop=document.getElementById('pop-up');
	btnCerrar=document.getElementById('btn-cerrar');


btnAbrir.addEventListener('click',function () {
	overlay.classList.add('active');
});
btnCerrar.addEventListener('click',function(){
	overlay.classList.remove('active');
});