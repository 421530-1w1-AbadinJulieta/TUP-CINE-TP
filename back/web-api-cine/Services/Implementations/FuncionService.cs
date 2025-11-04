using web_api_cine.Models.DTOs;
using web_api_cine.Repositories.Interfaces;
using web_api_cine.Services.Interfaces;

namespace web_api_cine.Services.Implementations
{
    public class FuncionService : IFuncionService
    {
        private readonly IFuncionRepository _repo;

        public FuncionService(IFuncionRepository repo)
        {
            _repo = repo;
        }
        public async Task<List<FuncionProgramadaDto>> ConsultarFunciones(string? titulo, string? genero, DateTime? fechaDesde, DateTime? fechaHasta, int? idCine)
        {
            if (fechaDesde.HasValue && fechaHasta.HasValue && fechaDesde > fechaHasta)
                throw new ArgumentException("La fecha 'Desde' no puede ser mayor que 'Hasta'.");

            return await _repo.ObtenerFuncionesAsync(titulo, genero, fechaDesde, fechaHasta, idCine);
        }
    }
}
