using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace USoft.Globalization
{
    public class CekSessions
    {
        private static Hashtable m_executingPages = new Hashtable();
        public CekSessions()
        { }
        public static string getUserId()
        {
            return HttpContext.Current.Session["UserId"].ToString();
        }
        public static void SessionStatus(string sMessage)
        {
            if (!m_executingPages.Contains(HttpContext.Current.Handler))
            {
                Page executingPage = HttpContext.Current.Handler as Page;
                if (executingPage != null)
                {
                    Queue messageQueue = new Queue();
                    messageQueue.Enqueue(sMessage);
                    m_executingPages.Add(HttpContext.Current.Handler, messageQueue);
                    executingPage.Unload += new EventHandler(ExecutingPage_Unload);
                }
            }
            else
            {
                Queue queue = (Queue)m_executingPages[HttpContext.Current.Handler];
                queue.Enqueue(sMessage);
            }

        }
        private static void ExecutingPage_Unload(object sender, EventArgs e)
        {
            Queue queue = (Queue)m_executingPages[HttpContext.Current.Handler];
            if (queue != null)
            {
                StringBuilder sb = new StringBuilder();
                int iMsgCount = queue.Count;
                sb.Append("<script language='javascript'>");
                string sMsg;
                while (iMsgCount-- > 0)
                {
                    sMsg = (string)queue.Dequeue();
                    sMsg = sMsg.Replace("\n", "\\n");
                    sMsg = sMsg.Replace("\"", "'");
                    sb.Append(@"alert( """ + sMsg + @""" );");
                }
                sb.Append(@"</script>");
                m_executingPages.Remove(HttpContext.Current.Handler);
                HttpContext.Current.Response.Write(sb.ToString());
            }
        }

        public static void SessionStatus(Page myPage)
        {
            if (HttpContext.Current.Session["UserId"] == null)
            {
                myPage.RegisterStartupScript("myScriptSessions", "<script language=JavaScript>window.parent.parent.cekSession();</script>");
            }
        }
        public static void UnBlockUI(Page myPage, UpdatePanel upd, ScriptManager scm)
        {
            ScriptManager.RegisterStartupScript(upd, upd.GetType(), "myScript", "window.parent.parent.closeWait();", true);
        }
        public static void UnBlockUI(Page myPage, ScriptManager scm)
        {
            ScriptManager.RegisterStartupScript(myPage, myPage.GetType(), "myScript", "window.parent.parent.closeWait();", true);
        }
        public static void BlockUI(Page myPage)
        {
            myPage.RegisterStartupScript("myScript", "<script language=JavaScript>window.parent.parent.loadWait();</script>");
        }
        public static void BlockUI(Page myPage, UpdatePanel upd, ScriptManager scm)
        {
            ScriptManager.RegisterStartupScript(upd, upd.GetType(), "myLoadScript", "window.parent.parent.loadWait();", true);
        }
        public static void OpenWindow(Page myPage, UpdatePanel upd, ScriptManager scm, string myString)
        {
            ScriptManager.RegisterStartupScript(upd, upd.GetType(), "myScript", "window.open('" + myString + "','','')", true);
        }
        public void UnBlockUI2(Button btn)
        {
            ScriptManager.RegisterOnSubmitStatement(btn, btn.GetType(), "myScript", "window.parent.parent.closeWait();");
        }
    }

}
