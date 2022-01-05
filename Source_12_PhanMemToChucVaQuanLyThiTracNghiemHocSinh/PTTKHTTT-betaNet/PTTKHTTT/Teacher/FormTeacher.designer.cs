
namespace PTTKHTTT.Teacher
{
    partial class FormTeacher
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormTeacher));
            this.mainContainer = new DevExpress.XtraBars.FluentDesignSystem.FluentDesignFormContainer();
            this.accordionControl1 = new DevExpress.XtraBars.Navigation.AccordionControl();
            this.accordionControlRegisExam = new DevExpress.XtraBars.Navigation.AccordionControlElement();
            this.accordionControlQues = new DevExpress.XtraBars.Navigation.AccordionControlElement();
            this.accordionControlExamDetails = new DevExpress.XtraBars.Navigation.AccordionControlElement();
            this.fluentDesignFormControl1 = new DevExpress.XtraBars.FluentDesignSystem.FluentDesignFormControl();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.nameLbl = new System.Windows.Forms.Label();
            this.idLbl = new System.Windows.Forms.Label();
            this.logoutBtn = new DevExpress.XtraEditors.SimpleButton();
            ((System.ComponentModel.ISupportInitialize)(this.accordionControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.fluentDesignFormControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // mainContainer
            // 
            this.mainContainer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.mainContainer.Location = new System.Drawing.Point(260, 30);
            this.mainContainer.Name = "mainContainer";
            this.mainContainer.Size = new System.Drawing.Size(714, 670);
            this.mainContainer.TabIndex = 0;
            // 
            // accordionControl1
            // 
            this.accordionControl1.Dock = System.Windows.Forms.DockStyle.Left;
            this.accordionControl1.Elements.AddRange(new DevExpress.XtraBars.Navigation.AccordionControlElement[] {
            this.accordionControlRegisExam,
            this.accordionControlQues,
            this.accordionControlExamDetails});
            this.accordionControl1.Location = new System.Drawing.Point(0, 30);
            this.accordionControl1.Name = "accordionControl1";
            this.accordionControl1.ScrollBarMode = DevExpress.XtraBars.Navigation.ScrollBarMode.Touch;
            this.accordionControl1.Size = new System.Drawing.Size(260, 670);
            this.accordionControl1.TabIndex = 1;
            this.accordionControl1.ViewType = DevExpress.XtraBars.Navigation.AccordionControlViewType.HamburgerMenu;
            // 
            // accordionControlRegisExam
            // 
            this.accordionControlRegisExam.Appearance.Hovered.BackColor = System.Drawing.Color.LightGray;
            this.accordionControlRegisExam.Appearance.Hovered.Options.UseBackColor = true;
            this.accordionControlRegisExam.Name = "accordionControlRegisExam";
            this.accordionControlRegisExam.Style = DevExpress.XtraBars.Navigation.ElementStyle.Item;
            this.accordionControlRegisExam.Text = "Đăng ký kiểm tra";
            this.accordionControlRegisExam.Click += new System.EventHandler(this.accordionControlRegisExam_Click);
            // 
            // accordionControlQues
            // 
            this.accordionControlQues.Appearance.Hovered.BackColor = System.Drawing.Color.LightGray;
            this.accordionControlQues.Appearance.Hovered.Options.UseBackColor = true;
            this.accordionControlQues.Expanded = true;
            this.accordionControlQues.Name = "accordionControlQues";
            this.accordionControlQues.Style = DevExpress.XtraBars.Navigation.ElementStyle.Item;
            this.accordionControlQues.Text = "Ngân hàng câu hỏi";
            this.accordionControlQues.Click += new System.EventHandler(this.accordionControlQues_Click);
            // 
            // accordionControlExamDetails
            // 
            this.accordionControlExamDetails.Appearance.Hovered.BackColor = System.Drawing.Color.LightGray;
            this.accordionControlExamDetails.Appearance.Hovered.Options.UseBackColor = true;
            this.accordionControlExamDetails.Name = "accordionControlExamDetails";
            this.accordionControlExamDetails.Style = DevExpress.XtraBars.Navigation.ElementStyle.Item;
            this.accordionControlExamDetails.Text = "Chi tiết bài thi";
            this.accordionControlExamDetails.Click += new System.EventHandler(this.accordionControlExamDetails_Click);
            // 
            // fluentDesignFormControl1
            // 
            this.fluentDesignFormControl1.FluentDesignForm = this;
            this.fluentDesignFormControl1.Location = new System.Drawing.Point(0, 0);
            this.fluentDesignFormControl1.Name = "fluentDesignFormControl1";
            this.fluentDesignFormControl1.Size = new System.Drawing.Size(974, 30);
            this.fluentDesignFormControl1.TabIndex = 2;
            this.fluentDesignFormControl1.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(0, 506);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(260, 76);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.CenterImage;
            this.pictureBox1.TabIndex = 3;
            this.pictureBox1.TabStop = false;
            // 
            // nameLbl
            // 
            this.nameLbl.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.nameLbl.Location = new System.Drawing.Point(0, 597);
            this.nameLbl.Name = "nameLbl";
            this.nameLbl.Size = new System.Drawing.Size(260, 15);
            this.nameLbl.TabIndex = 4;
            this.nameLbl.Text = "Trần Minh Chiến";
            this.nameLbl.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // idLbl
            // 
            this.idLbl.Font = new System.Drawing.Font("Verdana", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.idLbl.Location = new System.Drawing.Point(0, 612);
            this.idLbl.Name = "idLbl";
            this.idLbl.Size = new System.Drawing.Size(260, 22);
            this.idLbl.TabIndex = 5;
            this.idLbl.Text = "ID: GV21-001";
            this.idLbl.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // logoutBtn
            // 
            this.logoutBtn.Appearance.BackColor = System.Drawing.Color.Red;
            this.logoutBtn.Appearance.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.logoutBtn.Appearance.Options.UseBackColor = true;
            this.logoutBtn.Appearance.Options.UseFont = true;
            this.logoutBtn.Location = new System.Drawing.Point(0, 654);
            this.logoutBtn.Name = "logoutBtn";
            this.logoutBtn.Size = new System.Drawing.Size(260, 46);
            this.logoutBtn.TabIndex = 6;
            this.logoutBtn.Text = "Đăng xuất";
            this.logoutBtn.Click += new System.EventHandler(this.logoutBtn_Click);
            // 
            // FormTeacher
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(974, 700);
            this.ControlContainer = this.mainContainer;
            this.Controls.Add(this.logoutBtn);
            this.Controls.Add(this.idLbl);
            this.Controls.Add(this.nameLbl);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.mainContainer);
            this.Controls.Add(this.accordionControl1);
            this.Controls.Add(this.fluentDesignFormControl1);
            this.FluentDesignFormControl = this.fluentDesignFormControl1;
            this.Name = "FormTeacher";
            this.NavigationControl = this.accordionControl1;
            this.Text = "Phần mềm thi trắc nghiệm";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            ((System.ComponentModel.ISupportInitialize)(this.accordionControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.fluentDesignFormControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private DevExpress.XtraBars.FluentDesignSystem.FluentDesignFormContainer mainContainer;
        private DevExpress.XtraBars.Navigation.AccordionControl accordionControl1;
        private DevExpress.XtraBars.FluentDesignSystem.FluentDesignFormControl fluentDesignFormControl1;
        private DevExpress.XtraBars.Navigation.AccordionControlElement accordionControlQues;
        private DevExpress.XtraBars.Navigation.AccordionControlElement accordionControlExamDetails;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label nameLbl;
        private System.Windows.Forms.Label idLbl;
        private DevExpress.XtraBars.Navigation.AccordionControlElement accordionControlRegisExam;
        private DevExpress.XtraEditors.SimpleButton logoutBtn;
    }
}