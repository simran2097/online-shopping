<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="availableCount" value="${userModel.cart.cartLines}" />
<div class="container">


	<c:if test="${not empty message}">
		
		<div class="alert alert-info">
			<h3 class="text-center">${message}</h3>
		</div>		
	
	</c:if>
	
	<c:choose>
		<c:when test="${not empty cartLines}">
			<table id="cart" class="table table-hover table-condensed">
			   	<thead>
					<tr>
						<th style="width:50%">Product</th>
						<th style="width:10%">Price</th>
						<th style="width:8%">Quantity</th>
						<th style="width:22%" class="text-center">Subtotal</th>
						<th style="width:10%"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cartLines}" var="cartLine">
					<c:if test="${cartLine.available == false}">
						<c:set var="availableCount" value="${availableCount - 1}"/>
					</c:if>
					
					<tr>
						<td data-th="Product">
							<div class="row">
								<div class="col-sm-2 hidden-xs">
									<img src="${images}/${cartLine.product.code}.jpg" alt="${cartLine.product.name}" class="img-responsive dataTableImg"/></div>
								<div class="col-sm-10">
									<h4 class="nomargin">${cartLine.product.name} 
										<c:if test="${cartLine.available == false}">
											<strong style="color:red">(Not Available)</strong> 
										</c:if>
									</h4>
									<p>Brand : ${cartLine.product.brand}</p>
									<p>Description : ${cartLine.product.description}
								</div>
							</div>
						</td>
						<td data-th="Price"> &#8377; ${cartLine.buyingPrice} /-</td>
						<td data-th="Quantity">
							<input type="number" id="count_${cartLine.id}" class="form-control text-center" value="${cartLine.productCount}" min="1" max="3">
						</td>
						<td data-th="Subtotal" class="text-center">&#8377; ${cartLine.total} /-</td>
						<td class="actions" data-th="">
							<c:if test="${cartLine.available == true}">
								<button type="button" name="refreshCart" class="btn btn-info btn-sm" value="${cartLine.id}"><span class="glyphicon glyphicon-refresh"></span></button>
							</c:if>												
							<a href="${contextRoot}/cart/${cartLine.id}/remove" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash"></span></a>								
						</td>
					</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr class="visible-xs">
						<td class="text-center"><strong>Total &#8377; ${userModel.cart.grandTotal}</strong></td>
					</tr>
					<tr>
						<td><a href="${contextRoot}/show/all/products" class="btn btn-warning"><span class="glyphicon glyphicon-chevron-left"></span> Continue Shopping</a></td>
						<td colspan="2" class="hidden-xs"></td>
						<td class="hidden-xs text-center"><strong>Total &#8377; ${userModel.cart.grandTotal}/-</strong></td>
						
						<c:choose>
							<c:when test="${availableCount != 0}">
								<td>
								<div id="paypal-button"></div>
<script src="https://www.paypalobjects.com/api/checkout.js"></script>
<script>
paypal.Button.render({
  env: 'sandbox',
  client: {
    sandbox: 'demo_sandbox_client_id'
  },
  payment: function (data, actions) {
    return actions.payment.create({
      transactions: [{
        amount: {
          total: '${userModel.cart.grandTotal}',
          currency: 'USD'
        }
      }]
    });
  },
  onAuthorize: function (data, actions) {
    return actions.payment.execute()
      .then(function () {
        window.alert('Thank you for your purchase \u20B9 ${userModel.cart.grandTotal}!');
        window.location.href = "${contextRoot}/home";
      });
  }
}, '#paypal-button');
</script>
			</td>
			
</c:when>							
							<c:otherwise>
								<td>
								<div id="paypal-button"></div>
<script src="https://www.paypalobjects.com/api/checkout.js"></script>
<script>

function Redirect() {
    window.location="http://www.tutorialspoint.com";
}
paypal.Button.render({
  env: 'sandbox',
  client: {
    sandbox: 'demo_sandbox_client_id'
  },
  payment: function (data, actions) {
    return actions.payment.create({
      transactions: [{
        amount: {
          total: '${userModel.cart.grandTotal}',
          currency: 'USD'
        }
      }]
    });
  },
  onAuthorize: function (data, actions) {
    return actions.payment.execute()
      .then(function () {
        window.alert('Thank you for your purchase of ${userModel.cart.grandTotal}!');
      });
  }
}, '#paypal-button');

</script>
								</td>
							</c:otherwise>
						</c:choose>						
					</tr>
				</tfoot>
			</table>
		
		</c:when>
		
		<c:otherwise>
			
			<div class="jumbotron">
				
				<h3 class="text-center">Your Cart is Empty!</h3>
			
			</div>
		
		</c:otherwise>
	</c:choose>




</div>
