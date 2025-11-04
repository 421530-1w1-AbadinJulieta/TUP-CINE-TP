using web_api_cine.Models.DTOs;

namespace web_api_cine.Services.Interfaces
{
    public interface IFuncionService
    {
        Task<List<FuncionProgramadaDto>> ConsultarFunciones(
            string? titulo, string? genero, DateTime? fechaDesde, DateTime? fechaHasta, int? idCine);
    }
}
