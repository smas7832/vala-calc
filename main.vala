#!/usr/bin/env -S vala --pkg gtk4

public class Hello: Gtk.Application  {
	public Hello (){
		Object (application_id: "com.smas7832.hello");
	}

	enum Operation{
		SUM,
		SUB,
		MUL,
		DIV,
		NULL
	}

	Operation op = NULL;
	int input = 0;
	int input_buff = 0;


	string output_markup(string text){
		return "<span font_family=\"monospace\">%s</span>".printf(text);
	}
	
	int equaliser(int num1, int num2){
		int result = 0;
		switch (op){
			case SUM: result =  num1 + num2; break;
			case SUB: result =  num1 - num2; break;
			case MUL: result =  num1 * num2; break;
			case DIV: result =  num1 / num2; break;
			case NULL: result =  0; break;
		}
		return result;
	}
	public override void activate(){

		var Grid = new Gtk.Grid();
		Grid.row_spacing = 2;
		Grid.column_spacing = 2;
		var output_display = new Gtk.Label("0");
		output_display.set_xalign(0.9f);
		var operation_display = new Gtk.Label("");
		operation_display.set_xalign(0.3f);


		int counter = 1;
		for (int row = 1; row < 4; row++){
			for(int col = 0; col < 3; col++){
				int digit = counter;
				var btn = new Gtk.Button.with_label(digit.to_string());

				btn.clicked.connect(() => {
						input = input * 10 + digit;  
						output_display.set_markup(output_markup(input.to_string()));
				});

				counter++;
				Grid.attach(btn, col,row);
			}
		}

		var zero_button = new Gtk.Button();
		zero_button.set_label("0");
		zero_button.clicked.connect(()=>{
			input = input * 10;  
			output_display.set_markup(output_markup(input.to_string()));
		});

		var equal_button= new Gtk.Button.with_label("=");
		equal_button.clicked.connect(()=>{
			if( input == 0 | input_buff == 0){
				output_display.set_text("ERROR!");
			}else{
				int result = equaliser(input_buff, input);
				output_display.set_text(result.to_string());
				operation_display.set_text("=");

				input_buff = 0;
				input = result;
			}
		});

		var sum_button = new Gtk.Button.with_label("+");
		sum_button.clicked.connect(()=>{
			op = SUM;
			operation_display.set_text("+");
			input_buff = input;
			input = 0;
		});

		var sub_button = new Gtk.Button.with_label("-");
		sub_button.clicked.connect(()=>{
			op = SUB;
			operation_display.set_text("-");
			input_buff = input;
			input = 0;
		});

		var mul_button = new Gtk.Button.with_label("*");
		mul_button.clicked.connect(()=>{
			op = MUL;
			operation_display.set_text("*");
			input_buff = input;
			input = 0;
		});

		var div_button = new Gtk.Button.with_label("/");
		div_button.clicked.connect(() => {
			op = DIV;
			operation_display.set_text("/");
			input_buff = input;
			input = 0;
		});
		
		var clear_button = new Gtk.Button.with_label("X");
		clear_button.clicked.connect(()=>{
			output_display.set_text("CLEAR MEM!");
			operation_display.set_markup("");
			input = 0;
			input_buff =0;
			op = NULL;
		});


		Grid.attach(output_display,1,0 , 2 );
		Grid.attach(operation_display,0,0 , 1);
		Grid.attach(equal_button, 2, 4);
		Grid.attach(sum_button, 3, 4);
		Grid.attach(sub_button, 3, 3);
		Grid.attach(mul_button, 3, 2);
		Grid.attach(div_button, 3, 1);
		Grid.attach(clear_button, 3, 0);
		Grid.attach(zero_button, 1, 4);


		var win = new Gtk.ApplicationWindow(this){
			title ="Calculator",
			resizable = false
		};

		var about = new Gtk.AboutDialog();
		about.set_artists({"smas7832", "Vala"});
		about.set_comments("Fun lil study of GTK4-lib with Vala.");
		about.modal = true;
		about.set_hide_on_close(true);

		var about_button = new Gtk.Button.with_label("i");
		about_button.mnemonic_activate(true);
		about_button.clicked.connect(()=>{
			about.present();
		});
		
		var app_title = new Gtk.Label("Calculator");
		
		var app_header = new Gtk.HeaderBar();		
		app_header.set_title_widget(app_title);
		app_header.pack_start(about_button);


		win.set_titlebar(app_header);
		win.set_halign(5);
		win.set_valign(5);
		win.child = Grid;
		win.present();
	}
	static int main(string[] args){
		var app = new Hello();
		return app.run(args);
	}
}
