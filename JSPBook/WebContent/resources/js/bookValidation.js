function f_check(){
//	<script type="text/javascript" src="/resources/js/bookValidation.js"></script>
	let form = document.bookForm;
	let bookId = form.bookId.value;
	let name = form.name.value;
	let unitPrice = form.unitPrice.value;
	let unitsInStock = form.unitsInStock.value;
	
	var regExpId = /^ISBN/;
	var regExpId2 = /[0-9]+/;
	var regExpNum = /^[0-9]*$/;
	
	if((bookId.length < 5 || 12 < bookId.length) || !regExpId.test(bookId) || !regExpId2.test(bookId)){
		alert("[도서코드]\n"
			+ "ISBN과 숫자를 조합하여 5~12자까지 입력하세요\n"
			+ "첫글자는 반드시 ISBN로 시작하세요");
		return;
	}
	if(name.length < 4 || 12 < name.length){
		alert("[도서명]\n"
			+ "4~12자까지 입력하세요")
		return;
	}
	if(unitPrice.length == 0 || !regExpNum.test(unitPrice) || unitPrice < 0){
		alert("[가격]\n"
			+ "비어있지 않고 숫자만 입력가능합니다.\n"
			+ "양수만 입력하세요");
		return;
	}
	if(!regExpNum.test(unitsInStock) || unitsInStock.length == 0){
		alert("[재고수]\n"
			+"숫자만 입력하세요");
		return;
	}
	
	form.submit();
}