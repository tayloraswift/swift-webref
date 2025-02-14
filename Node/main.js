import { parseAll } from "@webref/idl";

console.log(JSON.stringify(await parseAll(), null, 2));
