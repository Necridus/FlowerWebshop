<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Bokréta e-virágbolt</title>
        <link rel="stylesheet" href="style.css">
    </head>

    <body>
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

        <form action="Order.jsp" method="post">

            <table>
                <tbody>
                    <tr>
                        <td>
                            Küldő:
                        </td>
                        <td>
                            <input type="text" size="20" name="sender">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Címzett:
                        </td>
                        <td>
                            <input type="text" size="20" name="addressee">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Cím:
                        </td>
                        <td>
                            <input type="text" size="50"  name="address">
                        </td>
                    </tr>
                </tbody>
            </table>

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
                <input type="radio" name="packing" value="normal" checked="checked"> normál
            </label>

            <br>

            <label>
                <input type="radio" name="packing" value="decor"> dísz
            </label>

            <br>
            <br>

            <input type="submit" value="Rendelés">

        </form>

    </body>
</html>