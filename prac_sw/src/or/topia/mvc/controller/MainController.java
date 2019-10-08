package or.topia.mvc.controller;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping(value= {"/","/index"})
	public String index()
	{
		Date date = new Date();
		return "home";
	}
}
