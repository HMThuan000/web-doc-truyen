using System.Collections;
using System.Data.SqlClient;


namespace DocTruyen.Models
{
    public class DataModel
    {
        private static DataModel instance;
        private static readonly object lockObject = new object();
        private static string connectionString = "Server=DESKTOP-THT31JA\\SQLEXPRESS;Database=QuanLyDocTruyen;Trusted_Connection=True";

        // Constructor private để ngăn chặn việc tạo đối tượng từ bên ngoài lớp
        private DataModel() { }

        // Phương thức static để truy cập đến thể hiện Singleton
        public static DataModel Instance
        {
            get
            {
                // Sử dụng double-checked locking để đảm bảo hiệu suất và độ an toàn
                if (instance == null)
                {
                    lock (lockObject)
                    {
                        if (instance == null)
                        {
                            instance = new DataModel();
                        }
                    }
                }
                return instance;
            }
        }

        public ArrayList Get(string sql)
        {
            ArrayList list = new ArrayList();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(sql, connection);
                connection.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        ArrayList row = new ArrayList();
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            row.Add(reader.GetValue(i).ToString());
                        }
                        list.Add(row);
                    }
                }
            }
            return list;
        }
    }
}