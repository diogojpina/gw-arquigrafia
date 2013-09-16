package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.ioc.Component;
import br.org.groupwareworkbench.collablet.coord.user.User;

import com.ibm.icu.text.SimpleDateFormat;

@Component
public class Analytics {
    
    private final HttpServletRequest request;

    public Analytics(HttpServletRequest request) {
        this.request = request;
    }

    public void save(String q) {
        User user = (User) request.getSession().getAttribute("userLogin");
        String path = System.getProperty("user.home") + "/analytics.txt";
        String now = new SimpleDateFormat("dd/MM/yyyy hh:mm").format(new Date());
        try {
            PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter(path, true)));
            writer.format("(%s, %s, %s)", user.getName(), now, q);
            writer.println();
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
