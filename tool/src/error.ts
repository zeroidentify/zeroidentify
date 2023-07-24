import { Common } from "./common"

export const SPECIAL_DELIMETER_STRING = "Jw9YsScN"

export async function error(err: Error): Promise<void> {
    let s: string
    if (err.stack !== undefined) {
        s = err.stack.toString()
    } else {
        s = "undefined"
    }
    const c = new Common()
    s = c.replaceString(s, String.fromCharCode(0), SPECIAL_DELIMETER_STRING)
    const args: string = encodeURIComponent(s)
}
