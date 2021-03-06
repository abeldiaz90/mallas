using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ArbolService.Models
{
    public class DaJerarquia
    {
        protected readonly ConexionBD Cn;
        protected SqlCommand cmd;
        public DaJerarquia(ConexionBD Cn)
        {
            this.Cn = Cn;
        }

        public List<RelacionMallas> ObtenerListaRelacionMallas(string malla)
        {
            List<RelacionMallas> listaRelacionMalla = new List<RelacionMallas>();
            SqlConnection cn = this.Cn.Connect();

            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_BuscarMalla ", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Malla", malla);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                RelacionMallas relacion = new RelacionMallas();
                relacion.Id = Convert.ToInt32(dr["Id"]);
                relacion.Parent = Convert.ToString(dr["Parent"]);
                relacion.Child = Convert.ToString(dr["Child"]);
                listaRelacionMalla.Add(relacion);
            }
            return listaRelacionMalla;
        }
        public List<Malla> ObtenerListaMallas()
        {
            List <Malla> listaMalla = new List<Malla>();
            SqlConnection cn = this.Cn.Connect();
            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_ListaMallas ", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Malla malla = new Malla();

                malla.malla = Convert.ToString(dr["Malla"]);

                listaMalla.Add(malla);
            }
            return listaMalla;
        }
        public List<Jobs> ObtenerListaJobs(string malla)
        {
            List<Jobs> listaJobs = new List<Jobs>();
            SqlConnection cn = this.Cn.Connect();

            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_ListaJobs ", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Malla", malla);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Jobs job = new Jobs();
                job.jobs = Convert.ToString(dr["Jobs"]);              
                listaJobs.Add(job);
            }
            return listaJobs;
        }

        // Obtener lista Predecesores
        public List<RelacionMallas> ObtenerListaPredecesores(string malla)
        {
            List<RelacionMallas> listaRelacionMalla = new List<RelacionMallas>();
            SqlConnection cn = this.Cn.Connect();

            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_BuscarPredecesores ", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Malla", malla);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                RelacionMallas relacion = new RelacionMallas();
                relacion.Id = Convert.ToInt32(dr["Id"]);
                relacion.Parent = Convert.ToString(dr["Parent"]);
                relacion.Child = Convert.ToString(dr["Child"]);
                listaRelacionMalla.Add(relacion);
            }
            return listaRelacionMalla;
        }

        // Obteniendo lista de jobs
        public List<Jobs> ObtenerListaJobsT()
        {
            List<Jobs> listaJobs = new List<Jobs>();
            SqlConnection cn = this.Cn.Connect();
            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_JobsTotal ", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Jobs job = new Jobs();

                job.jobs = Convert.ToString(dr["Jobs"]);

                listaJobs.Add(job);
            }
            return listaJobs;
        }

        // Obtener lista    Sucesores Jobs Totales
        public List<RelacionMallas> ObtenerListaSucesoresT(string jobs)
        {
            List<RelacionMallas> listaRelacionMalla = new List<RelacionMallas>();
            SqlConnection cn = this.Cn.Connect();

            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_BuscaForJobSucesor", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@forjob", jobs);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                RelacionMallas relacion = new RelacionMallas();
                relacion.Id = Convert.ToInt32(dr["Id"]);
                relacion.Parent = Convert.ToString(dr["Parent"]);
                relacion.Child = Convert.ToString(dr["Child"]);
                listaRelacionMalla.Add(relacion);
            }
            return listaRelacionMalla;
        }

        // Obtener lista Predecesores Jobs Totales
        public List<RelacionMallas> ObtenerListaPredecesoresT(string jobs)
        {
            List<RelacionMallas> listaRelacionMalla = new List<RelacionMallas>();
            SqlConnection cn = this.Cn.Connect();

            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_BuscaForJobPredecesor2", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@forjob", jobs);

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                RelacionMallas relacion = new RelacionMallas();
                relacion.Id = Convert.ToInt32(dr["Id"]);
                relacion.Parent = Convert.ToString(dr["Parent"]);
                relacion.Child = Convert.ToString(dr["Child"]);
                listaRelacionMalla.Add(relacion);
            }
            return listaRelacionMalla;
        }

        public List<Jobs> ListaJobsAutoComplete(String jobA)
        {
            List<Jobs> listaJobs = new List<Jobs>();
            SqlConnection cn = this.Cn.Connect();
            SqlDataReader dr = null;
            cn.Open();
            cmd = new SqlCommand("sp_listarJobsAutoComplete", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@job", jobA);
            dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                Jobs job = new Jobs();
                job.jobs = Convert.ToString(dr["Jobs"]);
                listaJobs.Add(job);
            }
            return listaJobs;
        }

    }
}