<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Bokréta e-virágbolt</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <c:choose>

        <c:when test="${pageContext.request.method eq 'GET'}">
            <h1 class="title">
                Bokréta e-virágbolt
            </h1>
            <br>
            <p class="italic">
                Lepje meg szeretteit egy csokor virággal!
            </p>
            <p class="bold">
                Személyes adatok
            </p>
            <br>
            <form action="index.jsp" method="post">
                    <label>
                        Küldő:&nbsp;&nbsp;&nbsp;
                             <input type="text" size="20" name="sender">
                    </label>
                <br>
                    <label>
                        Címzett:
                            <input type="text" size="20" name="addressee">
                    </label>
                <br>
                    <label>
                        Cím:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="text" size="50"  name="address">
                    </label>
                <br>
                <hr class="line">
                <p style="font-weight: bold">
                    Csokor virágai
                </p>
                <br>
                <label>
                    <input type="checkbox"  name="type" value="rose"> Rózsa&nbsp;&nbsp;&nbsp;
                </label>
                <select name="nbrOfRoses">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
                <br>
                <label>
                    <input type="checkbox"  name="type" value="gerbera"> Gerbera
                </label>
                <select name="nbrOfGerberas">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
                <br>
                <label>
                    <input type="checkbox"  name="type" value="lily"> Liliom&nbsp;&nbsp;
                </label>
                <select name="nbrOfLilies">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
                <br>

                <p class="bold">
                    Csomagolás
                </p>
                <label>
                    <input type="radio" name="packing" value="normal"> normál
                </label>
                <br>

                <label>
                    <input type="radio" name="packing" value="decor"> dísz
                </label>
                <br><br>
                <input type="submit" value="Rendelés">
            </form>
        </c:when>

        <c:otherwise>
            <%
                int totalCost = 0;
                int unitPriceOfRoses = 200;
                int unitPriceOfGerberas = 250;
                int unitPriceOfLilies = 200;

                int numberOfRoses = Integer.parseInt(request.getParameter("nbrOfRoses"));
                int numberOfGerberas = Integer.parseInt(request.getParameter("nbrOfGerberas"));
                int numberOfLilies = Integer.parseInt(request.getParameter("nbrOfLilies"));

                int normal = 100;
                int decor = 500;

                int deliveryPriceOnWeekends = 750;
                int deliveryPriceOnWorkdays = 500;

                int dayOfWeek = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);

            %>

            <%!
                public int CalculateTotalCost(int unitPrice, int numberOfFlowers){
                    return unitPrice * numberOfFlowers;
                }
            %>

        <c:choose>
            <c:when test="${(empty param.sender) || (empty param.address) || (empty param.addressee)}">
                <h1>A küldő, címzett és cím mezők kitöltése kötelező!</h1>
            </c:when>
            <c:when test="${(empty param.type)}">
                <h1>Legalább egy virágot válasszon ki a rendelés leadásához!</h1>
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
                        <c:if test="${typeOfFlower eq 'rose'}">
                            Rózsa: <%=numberOfRoses%> szál (Egységár: <%=unitPriceOfRoses%> Ft.)<br>
                            <%
                                totalCost += CalculateTotalCost(unitPriceOfRoses, numberOfRoses);
                            %>
                        </c:if>
                        <c:if test="${typeOfFlower eq 'gerbera'}">
                            Gerbera: <%=numberOfGerberas%> szál (Egységár: <%=unitPriceOfGerberas%> Ft.)<br>
                            <%
                                totalCost += CalculateTotalCost(unitPriceOfGerberas, numberOfGerberas);
                            %>
                        </c:if>
                        <c:if test="${typeOfFlower eq 'lily'}">
                            Liliom: <%=numberOfLilies%> szál (Egységár: <%=unitPriceOfLilies%> Ft.)<br>
                            <%
                                totalCost += CalculateTotalCost(unitPriceOfLilies, numberOfLilies);
                            %>
                        </c:if>
                    </c:forEach>
                </p>
                <h1>
                    Csomagolás típusa és ára:
                </h1>
                <p>
                    <c:choose>
                        <c:when test="${param.packing eq 'normal'}">
                            Normál (<%=normal%> Ft.)
                            <%
                                totalCost += normal;
                            %>
                        </c:when>
                        <c:when test="${param.packing eq 'decor'}">
                            Díszcsomagolás (<%=decor%> Ft.)
                            <%
                                totalCost += decor;
                            %>
                        </c:when>
                    </c:choose>
                </p>
                <h1>
                    Szállítási költség:
                </h1>
                <p>
                    <c:choose>
                        <c:when test="${dayOfWeek eq 1 || dayOfWeek eq 7}">
                            <%=deliveryPriceOnWeekends%> Ft. (hétvégi szállítási költség) ${dayOfWeek}
                            <%
                                totalCost += deliveryPriceOnWeekends;
                            %>
                        </c:when>
                        <c:otherwise>
                            <%=deliveryPriceOnWorkdays%> Ft. (hétköznapi szállítási költség)${dayOfWeek}
                            <%
                                totalCost += deliveryPriceOnWorkdays;
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
        </c:otherwise>
    </c:choose>
</body>
</html>