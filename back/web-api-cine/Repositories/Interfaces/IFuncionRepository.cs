using web_api_cine.Models.DTOs;

namespace web_api_cine.Repositories.Interfaces
{
    public interface IFuncionRepository
    {
        Task<List<FuncionProgramadaDto>> ObtenerFuncionesAsync(
            string? titulo, string? genero, DateTime? fechaDesde, DateTime? fechaHasta, int? idCine);
    }
}
