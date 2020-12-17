package com.gabigutu.calculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CalculatorServlet", value = "/calculator")
public class CalculatorServlet extends HttpServlet {

    public String pageTitle;
    public CalculatorService calculatorService;

    @Override
    public void init() throws ServletException {
        pageTitle = "Calculator";
        calculatorService = new CalculatorService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(200);

        PrintWriter printWriter = response.getWriter();
        float operationResult;
        try {
            float first = Float.parseFloat(request.getParameter("first"));
            float second = Float.parseFloat(request.getParameter("second"));
            char operation = request.getParameter("operation").charAt(0);

            operationResult = calculatorService.operation(first, second, operation);
        } catch (IOException exception) {
            System.err.println("IOException: " + exception.getMessage());
            response.setStatus(500);
            printWriter.println("IOException: " + exception.getMessage());
            return;
        } catch (NumberFormatException exception) {
            System.err.println("NumberFormatException: " + exception.getMessage());
            response.setStatus(500);
            printWriter.println("NumberFormatException: " + exception.getMessage());
            return;
        }

        printWriter.print(operationResult);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", pageTitle);
        getServletContext().getRequestDispatcher("/calculator.jsp").forward(request, response);
    }
}
