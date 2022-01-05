using DevExpress.LookAndFeel;
using DevExpress.Skins;
using DevExpress.UserSkins;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Windows.Forms;
using System.Data;
using System.Configuration;

namespace PTTKHTTT
{
    static class Program
    {
        public static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PTTKHTTT.Properties.Settings.KiemTraHSConnectionString"].ConnectionString);
        /*        public static String connStr = "Data Source=LAPTOP-1T0MKR0F\\MSSQLSERVER3;Initial Catalog=KiemTraHS;Integrated Security=true";
        */
        public static String connStr = "Data Source=DESKTOP-ETRRJQV;Initial Catalog=KiemTraHS;Persist Security Info=True;User ID=sa;Password=123";
        public static SqlDataReader myReader;

        public static String userName = "";
        public static String password = "";
        public static String hoten = "";
        public static int maLop = -1;
        public static String tenLop = "";

        public static int connection()
        {
            if(Program.conn != null && Program.conn.State == ConnectionState.Open)
            {
                Program.conn.Close();
            }
            try
            {
                Program.conn.ConnectionString = Program.connStr;
                Program.conn.Open();
                return 1;
            }catch(Exception e)
            {
                MessageBox.Show("Lỗi kết nối CSDL\n Bạn cần xem lại user và password\n" + e.Message, "Thông báo", MessageBoxButtons.OK);
                return 0;
            }
        }
        public static SqlDataReader execSqlDataReader(String str)
        {
            SqlDataReader myReader;
            SqlCommand sqlCommand = new SqlCommand(str, Program.conn);
            sqlCommand.CommandType = CommandType.Text;
            if (Program.conn.State == ConnectionState.Closed) Program.conn.Open();
            try
            {
                myReader = sqlCommand.ExecuteReader();
                return myReader;
            }
            catch (Exception e)
            {
                Program.conn.Close();
                MessageBox.Show(e.Message);
                return null;
            }
        }

        public static DataTable execSqlDataTable(String str)
        {
            DataTable dt = new DataTable();
            if (Program.conn.State == ConnectionState.Closed) Program.conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(str, Program.conn);
            da.Fill(dt);
            conn.Close();
            return dt;
        }

        public static int execNonQuery(String str)
        {
            SqlCommand sqlCommand = new SqlCommand(str, Program.conn);
            sqlCommand.CommandType = CommandType.Text;
            if (Program.conn.State == ConnectionState.Closed) Program.conn.Open();
            try
            {
                sqlCommand.ExecuteNonQuery();
                return 0;
            }
            catch (SqlException ex)
            {
                if (ex.Message.Contains("Error converting data type varchar to int"))
                    MessageBox.Show("Bạn format Cell lại cột \"Ngày Thi\" qua kiểu Number hoặc mở File Excel.");
                else MessageBox.Show(ex.Message);
                conn.Close();
                return ex.State;
            }
        }

        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FormLogin());
        }
    }
}
