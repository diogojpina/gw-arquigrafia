package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class SearchPage {

    private WebDriver driver;
    private String serverUrl = "http://localhost:8080/";
        
    public SearchPage(WebDriver driver) {
        this.driver = driver;
        this.driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

    
    public boolean message(String text) {
        return this.driver.getPageSource().contains(text);
    }


    public SearchPage visit() {
        driver.get(serverUrl + "GW-Application-Arquigrafia/18/");
        return this;
    }


    public SearchPage fill(String text) {
        this.driver.findElement(By.name("q")).sendKeys(text);
        return this;
    }


    public void find() {
        this.driver.findElement(By.className("search_bar_button")).submit();
    }

}
