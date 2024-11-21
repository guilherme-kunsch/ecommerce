import { useState } from "react";
import axios from "axios";

export function Form() {
  const [login, setLogin] = useState("");
  const [password, setPassword] = useState("");

  async function handleForm(event) {
    event.preventDefault();
    
    try {
      const response = await axios.post("http://localhost:3335/user/validationUser", {
        email: login,
        password: password,
      },
      {
        headers: {
          'Content-Type': 'application/json', 
        }
      });
      console.log("Usuário logado:", response.data);
    } catch (err) {
      console.error("Erro ao fazer login:", err);
    }
  }

  return (
    <div>
      <form onSubmit={handleForm}>
        <p className="text-white">Login</p>
        <input
          value={login}
          onChange={(e) => setLogin(e.target.value)}
          type="text"
          placeholder="Digite seu login"
        />
        <p className="text-white">Senha</p>
        <input
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          type="password"
          placeholder="Digite sua senha"
        />
        <button type="submit" className="text-white">
          Entrar
        </button>
      </form>
    </div>
  );
}
