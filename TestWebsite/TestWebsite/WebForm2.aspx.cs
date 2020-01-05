using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Configuration;
using System.Data.OleDb;

namespace TestWebsite
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CamudConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            con.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("insert into CamudProject (Date,Description,Category,Amount) values('"+txtDate.Text+"','"+txtDescription.Text+"','"+txtCatgory.Text+"','"+txtAmount.Text+"')",con); // Error happen here User Input is More then what is in Database set 
           // SqlCommand cmd = new SqlCommand("insert into CamudProject values('" + txtDate.Text + "','" + txtDescription.Text + "','" + txtCatgory + "','" + txtAmount + "') ", con);
           
            cmd.ExecuteNonQuery();
            con.Close();
            Label7.Visible = true;
            Label7.Text = "Success";
            gridview_data();
            //REFORMAT IT TO A BLANK 
            txtDate.Text = "";
            txtDescription.Text = "";
            txtCatgory.Text = "";
            txtAmount.Text = "";

            
        }

        public void gridview_data() 
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CamudConnectionString"].ConnectionString);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter("Select * from CamudProject",con);
            //SqlCommand refresh = new SqlCommand("Select * from CamudProject", con);
            //refresh.ExecuteNonQuery();


            DataSet1 ds = new DataSet1();
            da.Fill(ds, "insert_data");
            GridView1.DataSource = ds;
            GridView1.DataMember = "insert_data";
            GridView1.DataSourceID = null;
            //grid.DataSourceID = null;
            //grid.DataSource = dataTable;
            GridView1.DataBind();
            con.Close();
        }



        [WebMethod]
        public static List<string> GetDescription(string Description)
        {
            List<string> D1escription = new List<string>();
            OleDbConnection con2 = new OleDbConnection(@"Provider=SQLOLEDB; Data Source=DESKTOP-O9IMT6I;Initial Catalog=Camud;Integrated Security=SSPI");
            
            string query = string.Format("Select * From CamudProject where Description like '%{0}%'", Description);
            OleDbCommand cmdE = new OleDbCommand(query, con2);
            con2.Open();
            OleDbDataReader reader = cmdE.ExecuteReader();
            while(reader.Read())
            {
                D1escription.Add(string.Format("{0}", reader["Description"]));
                //D1escription.Add(reader.GetString(0));
                //Description.Add(string.Format("{0}", sdr["Description"]));
            }
            return D1escription;

        }


        //[WebMethod]
        //public static string[] GetDescription(string prefix)
        //{
        //    List<string> Description = new List<string>();
        //    using (SqlConnection conn = new SqlConnection())
        //    {
        //        conn.ConnectionString = ConfigurationManager.ConnectionStrings["CamudConnectionString"].ConnectionString;
        //        using (SqlCommand cmd = new SqlCommand())
        //        {
        //            cmd.CommandText = "select * from CamudProject where Description";
        //            cmd.Parameters.AddWithValue("@Description", prefix);
        //            cmd.Connection = conn;
        //            conn.Open();
        //            using (SqlDataReader sdr = cmd.ExecuteReader())
        //            {
        //                while (sdr.Read())
        //                {
        //                    Description.Add(string.Format("{0}", sdr["Description"]));
        //                }
        //            }
        //            conn.Close();
        //        }
        //    }
        //    return Description.ToArray();
        //}

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //SqlCommand refresh = new SqlCommand("Select * from CamudProject",con);
            //refresh.ExecuteNonQuery();
            //con.Close();

        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}