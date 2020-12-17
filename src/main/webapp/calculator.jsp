<%--
  Created by IntelliJ IDEA.
  User: gabigutu
  Date: 14/12/2020
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ro-RO">
<head>
    <title><%=request.getAttribute("pageTitle")%></title>
    <link rel="stylesheet" href="css/calculator.css" />

    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
</head>
<body>
<script type="text/javascript">
    let first = null;
    let second = null;
    let operation = null;

    function setValue(val) {
        if (operation == null) {
            if (first == null) {
                first = val;
            } else {
                first = first * 10 + val;
            }
            console.log('set first to ' + first);
        } else {
            if (second == null) {
                second = val;
            } else {
                second = second * 10 + val;
            }
            console.log('set second to ' + second);
        }
    }

    function clearCalc() {
        first = second = operation = null;
        console.log('set first to ' + first);
    }

    function setOperation(op)
    {
        operation = op;
        second = null;
        console.log('set operation to ' + operation);
    }

    function calculate() {
        console.log('Calculating ' + operation + ' for ' + first + ' and ' + second);
        switch (operation) {
            case '+':
                setResult(first + second);
                break;
            case '-':
                setResult(first - second);
                break;
            case ':':
                setResult(first / second);
                break;
            case '*':
                setResult(first * second);
                break;
        }
    }

    function calculateRemote() {
        const params = {
            'first': first,
            'second': second,
            'operation': operation
        };
        $.post( 'http://localhost:8080/HelloWorld_war_exploded/calculator', params, function( data ) {
            console.log(data);
            setResult(data);
            first = data;
        });
    }

    function setResult(result) {
        document.getElementsByClassName('calculator-screen')[0].value = result;
    }

</script>

<div class="calculator card">

    <label for="input-number">&nbsp;</label>
    <input id="input-number" type="text" class="calculator-screen z-depth-1" value="" disabled />

    <div class="calculator-keys">

        <button type="button" class="operator btn btn-info" value="+" onclick="setOperation('+');">+</button>
        <button type="button" class="operator btn btn-info" value="-" onclick="setOperation('-');">-</button>
        <button type="button" class="operator btn btn-info" value="*" onclick="setOperation('*');">&times;</button>
        <button type="button" class="operator btn btn-info" value="/" onclick="setOperation(':');">&divide;</button>

        <button type="button" value="7" class="btn btn-light waves-effect" onclick="setValue(7);">7</button>
        <button type="button" value="8" class="btn btn-light waves-effect" onclick="setValue(8);">8</button>
        <button type="button" value="9" class="btn btn-light waves-effect" onclick="setValue(9);">9</button>


        <button type="button" value="4" class="btn btn-light waves-effect" onclick="setValue(4);">4</button>
        <button type="button" value="5" class="btn btn-light waves-effect" onclick="setValue(5);">5</button>
        <button type="button" value="6" class="btn btn-light waves-effect" onclick="setValue(6);">6</button>


        <button type="button" value="1" class="btn btn-light waves-effect" onclick="setValue(1);">1</button>
        <button type="button" value="2" class="btn btn-light waves-effect" onclick="setValue(2);">2</button>
        <button type="button" value="3" class="btn btn-light waves-effect" onclick="setValue(3);">3</button>


        <button type="button" value="0" class="btn btn-light waves-effect" onclick="setValue(0);">0</button>
        <button type="button" class="decimal function btn btn-secondary" value=".">.</button>
        <button type="button" class="all-clear function btn btn-danger btn-sm" value="all-clear" onclick="clearCalc()">AC</button>

        <button type="button" class="equal-sign operator btn btn-default" value="=" onclick="calculateRemote();">=</button>

    </div>
</div>

</body>
</html>
