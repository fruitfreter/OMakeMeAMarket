open Yojson.Basic.Util
open String

type situation = {
  event : string;
  effect : string;
}


type fermiquestions = 
  {question : string;
   answer : string;
  }


type t = {
  id: string;
  fermi : fermiquestions list;
  situations : situation list
}


let situationsofjson json = 
  {
    event = json |> member "event" |> to_string ;
    effect = json |> member "effect" |> to_string ;
  }

let fermisofjson json = 
  {
    question = json |> member "question" |> to_string ;
    answer = json |> member "answer" |> to_string ;
  }

let from_json json = 
  {
    id = json |> member "id" |> to_string;
    fermi = json |> member "fermi" |> to_list |> List.map fermisofjson;
    situations = json |> member "situation" |> to_list |> List.map situationsofjson;
  }

(* Obtain a question from json *)
let get_question_struct (data : t) = 
  List.nth data.fermi (int_of_string data.id)

let get_question (data:t) : string = 
  let fermi_struct = get_question_struct data in 
  fermi_struct.question

let get_answer (data : t) : string = 
  let fermi_struct = get_question_struct data in 
  fermi_struct.answer

(* Obtain nth situation from json *)
let get_nth_situation (index: int ) (data : t) =
  List.nth data.situations index

(* Obtain event from a situation  *)
let get_event_from_situation (sit : situation) = 
  sit.event

(* Obtain effect from a situation.  Return an option indicating
   if it it causes the price to rise or to fall *)
let get_effect_from_situation (sit: situation) = 
  let s = (String.get sit.effect 0) in
  match s with
  | '+' -> Some ("increase", (String.sub (string_of_int 1) (String.length sit.effect)))
  | '-' -> Some ("increase", (String.sub (string_of_int 1) (String.length sit.effect)))
  | _ -> failwith "Error with situation's effect value in json"

(* Introduction *)
let introduction unit = 
  print_endline ("Welcome to OMakeMeAMarket!  Today, you are the sole market maker of a coin called CamelCoin that we have developed. \n");
  print_endline ("You will be making a market for several high frequency traders in USD.  To make a market, use the notation: bid@ask \n");
  print_endline ("For example, if your market is 10 USD to 20 USD, you write:  10@20.  Invalid inputs will prompt you again\n ");
  print_endline ("Now that we are familiar with the notation, let us reveal a hint to the true cost of a CamelCoin.   ")

