using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ComboBox = System.Windows.Forms.ComboBox;

namespace PTTKHTTT.Admin
{
    public partial class UCExamDetailsAdmin : DevExpress.XtraEditors.XtraUserControl
    {
        private static UCExamDetailsAdmin _instance;
        private int idSub;
        private int idClass;
        private int? idRegis;
        public static UCExamDetailsAdmin Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new UCExamDetailsAdmin();
                return _instance;
            }
        }
        public UCExamDetailsAdmin()
        {
            InitializeComponent();
            examsOfClassComboBox.ValueMember = "MaDangKy";
            examsOfClassComboBox.DisplayMember = "Display";
        }

        private void UCExamDetailsAdmin_Load(object sender, EventArgs e)
        {
            childContainer.Controls.Add(subsGridControl);
            subsGridControl.BringToFront();
            subsGridControl.Dock = DockStyle.Fill;
            try
            {
                this.sP_GetAllSubTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllSub);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
/*
            childContainer.Controls.Add(subsGridControl);
            subsGridControl.BringToFront();
            subsGridControl.Dock = DockStyle.Fill;
            try
            {
                this.sP_GetAllSubOfGrade_TeacherTableAdapter1.Fill(this.kiemTraHSDataSet.SP_GetAllSubOfGrade_Teacher, Program.userName);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }*/
        }

        /*private void subsTileView1_Click(object sender, EventArgs e)
        {
            childContainer.Controls.Add(examDetailForm);
            examDetailForm.BringToFront();
            examDetailForm.Dock = DockStyle.Fill;

            int index = subsTileView1.GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(subsTileView1.GetRow(index));
            idSub = (int)selRow["MaMon"];
            loadClassesTileView(idSub);
        }*/

        private void loadClassesTileView(int idSub)
        {
            try
            {
                this.sP_GetAllClass_ViewExamDetailTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllClass_ViewExamDetail, idSub);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
        }

        private void loadexamsOfClassComboBox(int idClass)
        {
            try
            {
                this.sP_GetAllExamsOfClassTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllExamsOfClass, idClass);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }

        }

        private void classTileView_Click(object sender, EventArgs e)
        {
            int index = classTileView.GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(classTileView.GetRow(index));
            idClass = (int)selRow["MaLop"];
            loadexamsOfClassComboBox(idClass);
        }

        private void examsOfClassComboBox_SelectedValueChanged(object sender, EventArgs e)
        {
            ComboBox combobox = sender as ComboBox;
            
            if (combobox.Items.Count > 0)
            {
                
                if(combobox.SelectedValue!=null)
                {
                    idRegis = (int)combobox.SelectedValue;
                    if (idRegis != null)
                    {
                        try
                        {
                            this.sP_GetAllStudentOfClassTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllStudentOfClass, idClass, idRegis);
                        }
                        catch (System.Exception ex)
                        {
                            System.Windows.Forms.MessageBox.Show(ex.Message);
                        }
                    }
                } 

            }
        }

        private void studentsGridView_CustomDrawRowIndicator(object sender, DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs e)
        {
            if (e.RowHandle >= 0)
                e.Info.DisplayText = (e.RowHandle + 1).ToString();
        }

        private void studentsGridView_CellValueChanged(object sender, DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs e)
        {
            
        }

        private void studentsGridView_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            examDetailPanel.Controls.Clear();
            int index = studentsGridView.GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(studentsGridView.GetRow(index));
            if (selRow == null) return;
            string idStudent = (string)selRow["MaHS"];

            DataTable dtExamDetail = new DataTable();
            String strGetExamDetail = "EXEC SP_GetExamDetail '" + idStudent + "'," + idRegis;
            try
            {
                dtExamDetail = Program.execSqlDataTable(strGetExamDetail);
                /*isEnough = (int)dtCheckEnoughQues.Rows[0]["result"];*/

            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi kiểm tra đăng ký\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }


            int vmf = dtExamDetail.Rows.Count;
            foreach (DataRow row in dtExamDetail.Rows)
            {
                //Tạo panel chứa 1 câu hỏi
                FlowLayoutPanel quesPnl = new FlowLayoutPanel();
                quesPnl.FlowDirection = FlowDirection.TopDown;
                quesPnl.Size = new Size(examDetailPanel.Width, examDetailPanel.Height/2-15);

                //Tạo panel chưa nội dung câu hỏi
                FlowLayoutPanel contentPnl = new FlowLayoutPanel();
                contentPnl.FlowDirection = FlowDirection.LeftToRight;
                /*contentPnl.Size = new Size(quesPnl.Width, 40);*/
                Label lbl = new Label();
                lbl.Text = "Câu ";
                lbl.AutoSize=true;

                Label serialQuesLbl = new Label();
                serialQuesLbl.Text = (int)row["STTCau"]+"";
                serialQuesLbl.AutoSize = true;

                Label contentQuesLbl = new Label();
                contentQuesLbl.Text = (string)row["NoiDung"];
                contentQuesLbl.AutoSize = true;

                contentPnl.Controls.Add(lbl);
                contentPnl.Controls.Add(serialQuesLbl);
                contentPnl.Controls.Add(contentQuesLbl);
                contentPnl.AutoSize = true;
                quesPnl.Controls.Add(contentPnl);

                String ans = (string)row["DapAn"];
                String choice = null;
                if (row["LuaChon"] == null) choice = null;
                else choice = row["LuaChon"].ToString();

                for (int i = 65; i <= 68; i++)
                {
                    //Tạo panel chứa nội dung các lựa chọn
                    FlowLayoutPanel optPnl = new FlowLayoutPanel();
                    optPnl.FlowDirection = FlowDirection.LeftToRight;
                    

                    Label optLbl = new Label();
                    string tmpOpt = ((char)i).ToString();
                    optLbl.Text = tmpOpt + ": ";
                    optLbl.AutoSize = true;


                    Label contentOptLbl = new Label();
                    contentOptLbl.Text = (string)row[tmpOpt];
                    contentOptLbl.AutoSize = true;

                    optPnl.Controls.Add(optLbl);
                    optPnl.Controls.Add(contentOptLbl);
                    optPnl.AutoSize = true;
                    quesPnl.Controls.Add(optPnl);

                    if (tmpOpt == choice)
                        optPnl.BackColor = Color.Red;
                    if(tmpOpt==ans)
                        optPnl.BackColor = Color.Green;

                }
                /*quesPnl.AutoSize = true;*/
                examDetailPanel.Controls.Add(quesPnl);
                /*examDetailPanel.Visible = true;
                examDetailPanel.Show();*/
            }
        }

        private void subsTileView1_Click_1(object sender, EventArgs e)
        {
            childContainer.Controls.Add(examDetailForm);
            examDetailForm.BringToFront();
            examDetailForm.Dock = DockStyle.Fill;
            int index = subsTileView1.GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(subsTileView1.GetRow(index));
            idSub = (int)selRow["MaMon"];
            loadClassesTileView(idSub);
            /*idGrade = (int)selRow["MaKhoi"];

            loadComboboxExamType(idGrade);

            int index = subsTileView1.GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(subsTileView1.GetRow(index));
            idSub = (int)selRow["MaMon"];
            loadClassesTileView(idSub);*/
        }

        private void exitBtn_Click(object sender, EventArgs e)
        {
            childContainer.Controls.Add(subsGridControl);
            subsGridControl.BringToFront();
            subsGridControl.Dock = DockStyle.Fill;
        }
    }
}
