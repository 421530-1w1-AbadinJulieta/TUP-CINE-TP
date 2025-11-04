function Titulo(props){
  const {children} = props;
  return (
    <div>
      <h1>{children}</h1>
    </div>
  );
}

export function SubTitulo(props){
  const {texto} = props;
  return (
    <div>
      <h2>{texto}</h2>
    </div>
  );
}
export default Titulo;