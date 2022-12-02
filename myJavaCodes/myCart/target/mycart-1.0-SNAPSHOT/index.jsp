<%@page import="com.uma.mycart.helper.FactoryProvider"%>
<%@page import ="com.uma.mycart.dao.ProductDao"%>
<%@page import ="com.uma.mycart.dao.CategoryDao"%>
<%@page import ="java.util.List"%>
<%@page import ="com.uma.mycart.entities.Product"%>
<%@page import ="com.uma.mycart.entities.Category"%>
<%@page import ="com.uma.mycart.helper.Helper"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Cart - Home</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    

        <%@include file="components/navbar.jsp" %>
        <div class="container-fluid">
        <div class="row mt-3 mx-2">

            <%
                String cat=request.getParameter("category");
                        //out.println(cat);
                
                
                ProductDao dao=new ProductDao(FactoryProvider.getFactory());
                List<Product> list=null;
                if(cat==null || cat.trim().equals("all"))
                {
                    list=dao.getAllProducts();
                }
                else
                {
                    int cid=Integer.parseInt(cat.trim());
                    list=dao.getAllProductsById(cid);
                }
                
                
                
                
                CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
                List<Category> clist=cdao.getCategories();
                
            %>    

            <!-- show categories -->
            <div class="col-md-2">
                <div class="list-group mt-4">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>

                    <%
                        for(Category c:clist)
                        {
                       
                    %>
                    <a href="index.jsp?category=<%= c.getCategoryId() %>" class="list-group-item list-group-item-action"><%= c.getCategoryTitle() %></a>

                    <%
                        }
                    %>
                </div>

            </div>

            <!--show products -->
            <div class="col-md-9">
                <!--row -->
                <div class="row mt-3">
                    <!--col:12 -->
                    <div class="col-md-12">
                        <div class="card-columns">
                            <!-- Traversing Products -->
                            <%
                               for(Product p:list)
                               {
                            %>  
                            <!-- Product card -->
                            <div class="product-card">
                                <div class="container text-center">
                                    <img src="img/products/<%= p.getpPhoto()%>" style="max-height:200px; max-width: 100%; width: auto;" class="card-img-top" alt="...">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-tilte"><%=p.getpName() %></h5>
                                    <p class="card-text">
                                        <%= Helper.get10Words(p.getpDesc())%>
                                    </p>
                                </div>

                                <div class="card-footer text-center">
                                    <button class="btn bg-warning text-black" onclick="add_to_cart(<%= p.getpId()%> , '<%=p.getpName()%>' , <%=p.getPriceAfterApplyingDiscount()%>)">Add to Cart</button>
                                    <button class="btn bg-success btn-outline-primary text-white"> &#8377; <%= p.getPriceAfterApplyingDiscount() %>/- (<span class="secondary discount-label">&#8377;<%= p.getpPrice() %>), <%= p.getpDiscount()%> % off </span> </button>

                                </div>
                            </div>


                            <%
                                 }
                                        
                                    if(list.size()==0)
                                    {
                                        out.println("<h3>No item in this category!!</h3>");
                                    }
                            %>   


                        </div>



                    </div>


                </div>
            </div>


        </div>
        </div>                     

                            <%@include file="components/common_modals.jsp" %>

    
</html>
