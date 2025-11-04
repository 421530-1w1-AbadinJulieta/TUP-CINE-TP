namespace web_api_cine.Models.DTOs
{
    public class FuncionProgramadaDto
    {
        public string Pelicula { get; set; }
        public string Genero { get; set; }

        public string Cine { get; set; }
        public string Sala { get; set; }
        public DateTime Fecha { get; set; }

        public TimeSpan Horario { get; set; }

        public string Idioma { get; set; }

        public string Duracion { get; set; }

        public string Clasificacion { get; set; }

    }
}
