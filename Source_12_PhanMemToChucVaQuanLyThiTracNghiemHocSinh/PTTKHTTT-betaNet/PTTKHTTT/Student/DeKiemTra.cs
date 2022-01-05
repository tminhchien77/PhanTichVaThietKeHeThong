using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PTTKHTTT
{
    class DeKiemTra
    {
        private String maCauHoi;
        private String noiDung;
        private String a;
        private String b;
        private String c;
        private String d;
        private String daChon;

        public DeKiemTra()
        {
        }

        public DeKiemTra(string maCauHoi, string noiDung, string a, string b, string c, string d, string daChon)
        {
            this.maCauHoi = maCauHoi;
            this.noiDung = noiDung;
            this.a = a;
            this.b = b;
            this.c = c;
            this.d = d;
            this.DaChon = daChon;
        }

        public string MaCauHoi { get => maCauHoi; set => maCauHoi = value; }
        public string NoiDung { get => noiDung; set => noiDung = value; }
        public string A { get => a; set => a = value; }
        public string B { get => b; set => b = value; }
        public string C { get => c; set => c = value; }
        public string D { get => d; set => d = value; }
        public string DaChon { get => daChon; set => daChon = value; }
    }
}
