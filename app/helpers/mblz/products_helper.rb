module Mblz::ProductsHelper
	def matrix(product)
		cat = product.product_category
		xmatrix = cat.matrix
		cols,rows = xmatrix.split('x')
		puts cols,rows
		s = ''
		x = 1
		located = nil
		1.upto(rows.to_i) do
			1.upto(cols.to_i) do
				located = (x == product.location ? 'located' : '')
				s += "<span class='matrix-location #{located}' data-location='#{x}'> * </span>"
  		  x += 1
	    end
      s += '<br/>'
		end
		("<div title='#{xmatrix}'>" + s + "</div>").html_safe
	end
end