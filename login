CODE DER LOGINSEIE:

   OHNE DB ANBINDUNG:

        if(txtBenutzername.Text == "Demo" && txtPasswort.Text == "12345")
        {
            Session["LoggedIn"] = "true";
            Response.Redirect("admin.aspx");
        } else
        {
            txtBenutzername.Text = "";
            txtPasswort.Text = "";
        }
        
        
    MIT DB ANBINDUNG:

        SqlConnection conASP = new SqlConnection(ConfigurationManager.ConnectionStrings["dbASPTestConnectionString"].ConnectionString);

        SqlCommand comASPLoginSelect = new SqlCommand("SELECT Benutzername, Passwort FROM tabBenutzer WHERE Benutzername = @Benutzername AND Passwort = @Passwort");
        comASPLoginSelect.Connection = conASP;
        comASPLoginSelect.Parameters.AddWithValue("@Benutzername", this.txtBenutzername.Text);
        comASPLoginSelect.Parameters.AddWithValue("@Passwort", this.txtPasswort.Text);
        comASPLoginSelect.Connection.Open();

        SqlDataReader drLogin = comASPLoginSelect.ExecuteReader();

        //Wenn Reihen rauskommen ist Benutzer und Passwort korrekt
        if (drLogin.HasRows == true)
        {
            Session["LoggedIn"] = "true";
            Response.Redirect("admin.aspx");
        } else
        {
            txtBenutzername.Text = "";
            txtPasswort.Text = "";
        }

        drLogin.Dispose();
        drLogin.Close();

        comASPLoginSelect.Dispose();
        comASPLoginSelect.Connection.Close();

        conASP.Dispose();
        conASP.Close();
        

CODE DER ADMINSEITE:

        //Testen ob User eingeloggt ist
        if(!(Session["LoggedIn"] != null && Session["LoggedIn"].ToString() == "true"))
        {
            Response.Redirect("login.aspx");
        }
