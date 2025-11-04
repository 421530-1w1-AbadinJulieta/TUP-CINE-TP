using Microsoft.AspNetCore.Mvc;
using web_api_cine.Models.DTOs;
using web_api_cine.Services.Interfaces;

namespace web_api_cine.Controller
{
    
        [ApiController]
        [Route("api/[controller]")]
        public class FuncionesController : ControllerBase
        {
            private readonly IFuncionService _service;

            public FuncionesController(IFuncionService service)
            {
                _service = service;
            }

            [HttpGet("Consultar")]
            public IActionResult ConsultarFunciones(
                [FromQuery] string? titulo,
                [FromQuery] string? genero,
                [FromQuery] DateTime? fechaDesde,
                [FromQuery] DateTime? fechaHasta,
                [FromQuery] int? idCine)
            {
                try
                {
                    // llamada directa, sin async/await
                    List<FuncionProgramadaDto> funciones =/*_service.ConsultarFunciones(
                        titulo, genero, fechaDesde, fechaHasta, idCine);*/

                    if (funciones == null || funciones.Count == 0)
                        return NotFound("No se encontraron funciones con los filtros seleccionados.");

                    return Ok(funciones);
                }
                catch (ArgumentException ex)
                {
                    return BadRequest(new { mensaje = ex.Message });
                }
                catch (Exception ex)
                {
                    return StatusCode(500, new { mensaje = "Error interno del servidor", detalle = ex.Message });
                }
            }
        }
    }

