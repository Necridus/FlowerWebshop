<%--
  Created by IntelliJ IDEA.
  User: kimme
  Date: 2021. 10. 09.
  Time: 11:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>Rendelés visszaigazolása</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<%
    int totalCost=0;
    int unitPriceOfRoses=200;
    int unitPriceOfGerberas=250;
    int unitPriceOfLilies=200;

    int numberOfRoses = Integer.parseInt(request.getParameter("nbrOfRoses"));
    int numberOfGerberas = Integer.parseInt(request.getParameter("nbrOfGerberas"));
    int numberOfLilies = Integer.parseInt(request.getParameter("nbrOfLilies"));

    int normal=100;
    int decor=500;

    int deliveryPriceOnWeekends=750;
    int deliveryPriceOnWorkdays=500;

    int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);
    request.setAttribute("dayOfWeek", dayOfWeek);

%>
<%!
    public int CalculateTotalCost(int unitPrice, int numberOfFlowers){
        return unitPrice*numberOfFlowers;
    }
%>
<c:out value="${resp}"/>

<c:choose>
    <c:when test="${(empty param.sender) || (empty param.address) || (empty param.addressee)}">
        <h1>A küldő, címzett és cím mezők kitöltése kötelező!</h1>
    </c:when>
    <c:otherwise>
        <h1>
            A megrendelő által megadott adatok:
        </h1>
        <p>
                Küldő: ${param.sender}
        </p>
        <p>
                Címzett: ${param.addressee}
        </p>
        <p>
                Cím: ${param.address}
        </p>
        <hr class="line">
        <h1>
            A megrendelés tartalma és ára:
        </h1>
        <p>
            <c:forEach var="typeOfFlower" items="${paramValues.type}">
                <c:if test="${typeOfFlower=='rose'}">
                    Rózsa: <%=numberOfRoses%> szál (Egységár: <%=unitPriceOfRoses%> Ft.)<br>
                    <%
                        totalCost+=CalculateTotalCost(unitPriceOfRoses,numberOfRoses);
                    %>
                </c:if>
                <c:if test="${typeOfFlower=='gerbera'}">
                    Gerbera: <%=numberOfGerberas%> szál (Egységár: <%=unitPriceOfGerberas%> Ft.)<br>
                    <%
                        totalCost+=CalculateTotalCost(unitPriceOfGerberas,numberOfGerberas);
                    %>
                </c:if>
                <c:if test="${typeOfFlower=='lily'}">
                    Liliom: <%=numberOfLilies%> szál (Egységár: <%=unitPriceOfLilies%> Ft.)<br>
                    <%
                        totalCost+=CalculateTotalCost(unitPriceOfLilies,numberOfLilies);
                    %>
                </c:if>
            </c:forEach>
        </p>
        <h1>
           Csomagolás típusa és ára:
        </h1>
        <p>
            <c:choose>
                <c:when test="${param.packing=='normal'}">
                    Normál (<%=normal%> Ft.)
                    <%
                        totalCost+=normal;
                    %>
                </c:when>
                <c:when test="${param.packing=='decor'}">
                    Díszcsomagolás (<%=decor%> Ft.)
                    <%
                        totalCost+=decor;
                    %>
                </c:when>
            </c:choose>
        </p>
        <h1>
            Szállítási költség:
        </h1>
        <p>
            <c:choose>
                <c:when test="${dayOfWeek == 1 || dayOfWeek == 7}"> <%--ide kellene a day variable--%>
                    <%=deliveryPriceOnWeekends%> Ft. (hétvégi szállítási költség)
                    <%
                        totalCost+=deliveryPriceOnWeekends;
                    %>
                </c:when>
                <c:otherwise>
                    <%=deliveryPriceOnWorkdays%> Ft. (hétköznapi szállítási költség)
                    <%
                        totalCost+=deliveryPriceOnWorkdays;
                    %>
                </c:otherwise>
            </c:choose>
        </p>
        <h1>
            Teljes költség: <%=totalCost%> Ft.
        </h1>
    </c:otherwise>
</c:choose>

<h3><a href="index.jsp">Vissza</a></h3>
</body>
</html>
