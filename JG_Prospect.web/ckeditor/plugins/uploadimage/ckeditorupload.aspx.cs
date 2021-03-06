﻿
using JG_Prospect.BLL;
using JG_Prospect.Common.modal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace JG_Prospect.Sr_App
{
    public partial class ckeditorupload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               

                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(SaveUploadedFile(Request.Files));
                Response.End();
            }
        }
        
        /// <summary>
        /// Save all uploaded image
        /// </summary>
        /// <param name="httpFileCollection"></param>
        public string SaveUploadedFile(HttpFileCollection httpFileCollection)
        {
            String response = "{\"uploaded\": 1,\"fileName\": \"**filename**\",\"url\": \"/TaskAttachments/**filename**\"}|";
            //bool isSavedSuccessfully = true;
            //string fName = "";
            foreach (string fileName in httpFileCollection)
            {
              HttpPostedFile file = httpFileCollection.Get(fileName);
              response = response.Replace("**filename**", UploadAttachment(file));                
            }

            return response;
        }
        
        public string UploadAttachment(HttpPostedFile file)
        {
            string fileName = string.Empty;
                       
            if (file != null && file.ContentLength > 0)
            {
                var originalDirectory = new DirectoryInfo(Server.MapPath("~/TaskAttachments"));

                string imageName = Path.GetFileName(file.FileName);
                string NewImageName = Guid.NewGuid() + "-" + imageName;

                string pathString = System.IO.Path.Combine(originalDirectory.ToString(),NewImageName);

                bool isExists = System.IO.Directory.Exists(originalDirectory.ToString());

                if (!isExists)
                    System.IO.Directory.CreateDirectory(originalDirectory.ToString());
                
                file.SaveAs(pathString);

                fileName = NewImageName;
            }

            return fileName;         
        }

       
        

    }
}