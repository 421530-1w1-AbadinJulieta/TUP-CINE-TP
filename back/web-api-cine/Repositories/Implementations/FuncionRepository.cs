using Microsoft.EntityFrameworkCore;
using web_api_cine.Models;
using web_api_cine.Models.DTOs;
using web_api_cine.Repositories.Interfaces;

namespace web_api_cine.Repositories.Implementations
{
    public class FuncionRepository : IFuncionRepository
    {
        private readonly cine_dbContext _context;
        public FuncionRepository(cine_dbContext context)
        {
            _context = context;
        }
        public async Task<List<FuncionProgramadaDto>> ObtenerFuncionesAsync(string? titulo, string? genero, DateTime? fechaDesde, DateTime? fechaHasta, int? idCine)
        {
            var result = await _context.Set<FuncionProgramadaDto>()
                .FromSqlRaw("EXEC SP_CONSULTAR_FUNCIONES_CINE @p0, @p1, @p2, @p3, @p4",
                    titulo ?? (object)DBNull.Value,
                    genero ?? (object)DBNull.Value,
                    fechaDesde ?? (object)DBNull.Value,
                    fechaHasta ?? (object)DBNull.Value,
                    idCine ?? (object)DBNull.Value)
                .ToListAsync();

            return result;
        }
    }
}
