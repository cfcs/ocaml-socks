#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  let mirage = Conf.with_pkg ~default:false "mirage" in
  let lwt = Conf.with_pkg ~default:true "lwt" in
  let opams =
    [ Pkg.opam_file "opam" ]
  in
  Pkg.describe ~opams "socks" @@ fun c ->
  let mirage = Conf.value c mirage in
  let lwt = Conf.value c lwt in
  Ok [ Pkg.mllib "src/socks.mllib"
     ; Pkg.mllib ~cond:mirage "mirage/socks.mllib"
     ; Pkg.mllib ~cond:lwt "src/socks_lwt.mllib"
     ; Pkg.test "test/test"
     ]
