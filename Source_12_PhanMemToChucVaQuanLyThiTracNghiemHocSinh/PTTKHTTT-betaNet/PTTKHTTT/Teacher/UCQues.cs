using DevExpress.XtraEditors;
using DevExpress.XtraGrid.Views.Grid;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static PTTKHTTT.SystemConstant;

namespace PTTKHTTT.Teacher
{
    public partial class UCQues : DevExpress.XtraEditors.XtraUserControl
    {
        private static UCQues _instance;
        private int idSub;
        private int position = 0;
        private int idLesson = -1;
        private ActionType _actionType = ActionType.READING;
        public static UCQues Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new UCQues();
                return _instance;
            }
        }
        public UCQues()
        {
            InitializeComponent();
        }

        private void UCQues_Load(object sender, EventArgs e)
        {
            childContainer.Controls.Add(sP_GetAllSubOfGrade_TeacherGridControl);
            sP_GetAllSubOfGrade_TeacherGridControl.BringToFront();
            sP_GetAllSubOfGrade_TeacherGridControl.Dock = DockStyle.Fill;
            try
            {
                this.sP_GetAllSubOfGrade_TeacherTableAdapter1.Fill(this.kiemTraHSDataSet.SP_GetAllSubOfGrade_Teacher, "GV21-001");
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
        }

        private void subsTileView_Click(object sender, EventArgs e)
        {
            childContainer.Controls.Add(quesForm);
            quesForm.BringToFront();
            quesForm.Dock = DockStyle.Fill;
            int index = subsTileView.GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(subsTileView.GetRow(index));
            idSub = (int)selRow["MaMon"];

            /*loadCombobox
             * 
             * 
             * 
             * 
             * 
             * ExamType();
            loadGridViewClasses("GV21-001", idSub);*/



            loadTreeViewLessons();
        }
        private void loadTreeViewLessons()
        {
            DataTable dt = new DataTable();
            String str = "EXEC SP_GetAllLessonsBySub " + idSub;
            try
            {
                dt = Program.execSqlDataTable(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi tải câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
            /*            foreach (DataRow dr in dt.Rows)
            */
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                foreach (TreeNode parentNode in treeViewLessons.Nodes)
                {
                    if (dt.Rows[i]["MaHocKy"].ToString().CompareTo(parentNode.Tag) == 0)
                    {
                        TreeNode node = new TreeNode((string)dt.Rows[i]["TenBai"]);
                        node.Tag = dt.Rows[i]["MaBaiHoc"];
                        parentNode.Nodes.Add(node);
                    }
                }
            }
        }

        private void treeViewLessons_NodeMouseClick(object sender, TreeNodeMouseClickEventArgs e)
        {
            if (e.Node.Parent != null)
            {
                try
                {
                    this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, (int?)e.Node.Tag);
                }
                catch (System.Exception ex)
                {
                    System.Windows.Forms.MessageBox.Show(ex.Message);
                }
                idLesson = (int)e.Node.Tag;
                lessonLabelControl.Text = e.Node.Text;
            }
            else
            {
                lessonLabelControl.Text = "";
            }
        }

        private void addBtn_Click(object sender, EventArgs e)
        {
            _actionType = ActionType.ADDING;
            position = quesBindingSource.Position;
            dataEntryGroupControl.Enabled = true;
            quesBindingSource.AddNew();

            addBtn.Enabled = false;
            ansComboBox.SelectedIndex = 0;
            statusCheckEdit.Checked = true;
        }

        private void lessonLabelControl_TextChanged(object sender, EventArgs e)
        {
            if (lessonLabelControl.Text.Length > 0)
            {
                addBtn.Enabled = true;
            }
        }

        private void undoBtn_Click(object sender, EventArgs e)
        {
            quesBindingSource.CancelEdit();
            if (!addBtn.Enabled) //Đang thêm
            {
                quesBindingSource.Position = position;
            }
            addBtn.Enabled = deleteBtn.Enabled /*= exitBtn.Enabled*/ = true;
        }

        private void deleteBtn_Click(object sender, EventArgs e)
        {


            Int32 isUsed = 0;

            int index = ((GridView)quesGridControl.MainView).GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(((GridView)quesGridControl.MainView).GetRow(index));


            int idQues = (int)selRow["MaCauHoi"];

            SqlDataReader myReader;
            SqlCommand sqlCommand = new SqlCommand("SELECT dbo.fn_isUsed(@idQues)", Program.conn);

            sqlCommand.Parameters.Add("idQues", SqlDbType.Int).Value = idQues;
            if (Program.conn.State == ConnectionState.Closed) Program.conn.Open();
            try
            {
                isUsed = Convert.ToInt32(sqlCommand.ExecuteScalar());
            }
            catch (Exception ex)
            {
                Program.conn.Close();
                MessageBox.Show(ex.Message);
                return;
            }

            if (isUsed == 0)
            {
                if (MessageBox.Show("Bạn có thật sự muốn xoá câu hỏi này?", "Xác nhận",
                    MessageBoxButtons.OKCancel) == DialogResult.OK)
                {
                    try
                    {
                        quesBindingSource.RemoveCurrent();

                        removeQues(idQues);
                        this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, idLesson);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Lỗi xoá câu hỏi\n" + ex.Message, "Thông báo lỗi", MessageBoxButtons.OK);
                        this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, idLesson);
                        quesBindingSource.Position = quesBindingSource.Find("MaCauHoi", idQues);
                        return;
                    }
                }
            }
            else
            {
                if (MessageBox.Show("Không thể xoá câu hỏi này!\nBạn có muốn huỷ trạng thái sử dụng của câu hỏi này?", "Xác nhận",
                    MessageBoxButtons.OKCancel) == DialogResult.OK)
                {
                    try
                    {
                        quesBindingSource.RemoveCurrent();
                        updateStatusQues(idQues);
                        this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, idLesson);
                        quesBindingSource.Position = quesBindingSource.Find("MaCauHoi", idQues);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Lỗi xoá câu hỏi\n" + ex.Message, "Thông báo lỗi", MessageBoxButtons.OK);
                        this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, idLesson);
                        quesBindingSource.Position = quesBindingSource.Find("MaCauHoi", idQues);
                        return;
                    }
                    /*statusCheckEdit.Checked = false;*/
                    /*try
                    {
                        quesBindingSource.EndEdit();
                        quesBindingSource.ResetCurrentItem();
                        this.quesTableAdapter.Connection.ConnectionString = Program.connStr;
                        this.quesTableAdapter.Adapter.Update(this.kiemTraHSDataSet.NH_CAUHOI);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Lỗi thêm câu hỏi\n" + ex.Message, "Thông báo lỗi", MessageBoxButtons.OK);
                        return;
                    }*/
                }
            }
            /*treeViewLessons.Enabled = */addBtn.Enabled = deleteBtn.Enabled /*= exitBtn.Enabled *//*= quesGridControl.Enabled*/ = true;
            
        }

        private void updateStatusQues(int idQues)
        {
            String str = "UPDATE NH_CAUHOI SET TrangThai=0 WHERE MaCauHoi =" + idQues;

            try
            {
                Program.execNonQuery(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi huỷ câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
        }

        private void removeQues(int idQues)
        {
            String str = "DELETE FROM NH_CAUHOI WHERE MaCauHoi =" + idQues;

            try
            {
                Program.execNonQuery(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi tải câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
        }

        private void saveBtn_Click(object sender, EventArgs e)
        {
            
            if (contentRichTextBox.Text.Trim().Length == 0)
            {
                MessageBox.Show("Nội dung câu hỏi không được rỗng!", "Thông báo lỗi", MessageBoxButtons.OK);
                contentRichTextBox.Focus();
                return;
            }
            if (aOptionRichTextBox.Text.Trim().Length == 0 || bOptionRichTextBox.Text.Trim().Length == 0 || cOptionRichTextBox.Text.Trim().Length == 0 || dOptionRichTextBox.Text.Trim().Length == 0)
            {
                MessageBox.Show("Các lựa chọn không được rỗng!", "Thông báo lỗi", MessageBoxButtons.OK);
                if (aOptionRichTextBox.Text.Trim().Length == 0) aOptionRichTextBox.Focus();
                else if(bOptionRichTextBox.Text.Trim().Length == 0) bOptionRichTextBox.Focus();
                else if (cOptionRichTextBox.Text.Trim().Length == 0) cOptionRichTextBox.Focus();
                else dOptionRichTextBox.Focus();
                return;
            }
            if(checkDupdlicateOption(aOptionRichTextBox.Text.Trim(), bOptionRichTextBox.Text.Trim(), cOptionRichTextBox.Text.Trim(), dOptionRichTextBox.Text.Trim()))
            {
                MessageBox.Show("Các lựa chọn không được trùng nhau!", "Thông báo lỗi", MessageBoxButtons.OK);
                return;
            }
            if (_actionType == ActionType.ADDING)
            {
                try
                {
                    insertQues(contentRichTextBox.Text, aOptionRichTextBox.Text,
                        bOptionRichTextBox.Text, cOptionRichTextBox.Text,
                        dOptionRichTextBox.Text, ansComboBox.SelectedItem.ToString(),
                        (int)statusCheckEdit.CheckState, idLesson);
                    this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, idLesson);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Lỗi thêm câu hỏi\n" + ex.Message, "Thông báo lỗi", MessageBoxButtons.OK);
                    return;
                }
            }
            else
            {
                int indexSelection = quesGridView.GetSelectedRows().FirstOrDefault();
                DataRowView selRow = (DataRowView)(((GridView)quesGridControl.MainView).GetRow(indexSelection));
                int idQues = (int)selRow["MaCauHoi"];
                try
                {
                    /*quesBindingSource.RemoveCurrent();*/
                    updateQues(idQues);
                    this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, idLesson);
                    quesBindingSource.Position = quesBindingSource.Find("MaCauHoi", idQues);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Lỗi hiệu chỉnh câu hỏi\n" + ex.Message, "Thông báo lỗi", MessageBoxButtons.OK);
                    this.quesTableAdapter.Fill(this.kiemTraHSDataSet.SP_GetAllQuesByLesson, idLesson);
                    quesBindingSource.Position = quesBindingSource.Find("MaCauHoi", idQues);
                    return;
                }
            }
            _actionType = ActionType.READING;
            addBtn.Enabled = deleteBtn.Enabled = /*exitBtn.Enabled =*/ true;

        }

        private void updateQues(int idQues)
        {

            String str = "UPDATE NH_CAUHOI SET " +
                            "NoiDung = N'" + contentRichTextBox.Text.Trim() + "', " +
                            "A = N'" + aOptionRichTextBox.Text.Trim() + "', " +
                            "B = N'" + bOptionRichTextBox.Text.Trim() + "', " +
                            "C = N'"+cOptionRichTextBox.Text.Trim() + "', " +
                            "D = N'"+dOptionRichTextBox.Text.Trim() + "', " +
                            "TrangThai = "+(int)statusCheckEdit.CheckState+" " +
                            "WHERE MaCauHoi = "+ idQues;

            try
            {
                Program.execNonQuery(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi hiệu chỉnh câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
        }

        private bool checkDupdlicateOption(string v1, string v2, string v3, string v4)
        {
            string[] array = { v1, v2, v3, v4 };

            for(int i=0; i<array.Length-1;i++)
            {
                for (int j = i + 1; j < array.Length; j++)
                {
                    if (array[i].CompareTo(array[j]) == 0) return true;
                }
            }
            return false;
        }

        private void insertQues(string content, string a, string b, string c, string d, string ans, int checkState, int idLesson)
        {
            String str = "INSERT INTO NH_CAUHOI " +
                "(NoiDung, A, B, C, D, DapAn, TrangThai, MaBaiHoc)" +
                "VALUES (N'"+content+"', N'"+a+ "', N'" + b + "', N'" + c + "', N'" + d + "', '" + ans + "', "+checkState+", " +idLesson+ ")";

            try
            {
                Program.execNonQuery(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi thêm câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
        }

        private void exitBtn_Click(object sender, EventArgs e)
        {
            /*childContainer.Controls.Add(subsTileView);
            quesForm.BringToFront();
            quesForm.Dock = DockStyle.Fill;*/

            childContainer.Controls.Add(sP_GetAllSubOfGrade_TeacherGridControl);
            sP_GetAllSubOfGrade_TeacherGridControl.BringToFront();
            sP_GetAllSubOfGrade_TeacherGridControl.Dock = DockStyle.Fill;
        }

        private void gridView1_RowCountChanged(object sender, EventArgs e)
        {
            if (quesBindingSource.Count == 0) deleteBtn.Enabled = false;
            else
            {
                if (!saveBtn.Enabled) deleteBtn.Enabled = true;
            }
        }

        private void addBtn_EnabledChanged(object sender, EventArgs e)
        {
            undoBtn.Enabled= dataEntryGroupControl.Enabled = saveBtn.Enabled = !addBtn.Enabled;
            deleteBtn.Enabled= quesGridControl.Enabled = treeViewLessons.Enabled = exitBtn.Enabled = addBtn.Enabled;
            if (!addBtn.Enabled) deleteBtn.Enabled = editBtn.Enabled = false;
        }

        private void editBtn_Click(object sender, EventArgs e)
        {
            addBtn.Enabled = editBtn.Enabled = false;
            _actionType = ActionType.EDITING;
        }

        private void gridView1_RowCellClick(object sender, RowCellClickEventArgs e)
        {

        }

        private void gridView1_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            if (quesBindingSource.Count == 0)
            {
                editBtn.Enabled = deleteBtn.Enabled = false;
                return;

            }
            editBtn.Enabled = deleteBtn.Enabled = true;
        }
    }
}
