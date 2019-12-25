

radio.setGroup(1)
let gotID = false
let thisID = 0
let thisIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

basic.showLeds(`
    # . . . #
    # . . . #
    # . . . #
    # # # # #
    # # # # #
    `)
pins.digitalWritePin(DigitalPin.P1, 0)

basic.pause(1000)
basic.showIcon(IconNames.Happy)

/* get id from Top for broadcasting */
while (!gotID) {
    basic.pause(50)
    if (pins.digitalReadPin(DigitalPin.P2) == 1) {
        thisID = 0
        thisIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        basic.pause(100)
        for (let index = 0; index <= 9; index++) {
            basic.pause(10)
            thisIDbits[index] = pins.digitalReadPin(DigitalPin.P2)
            basic.pause(90)
        }
        for (let index = 0; index <= 9; index++) {
            if (thisIDbits[index] > 0)
                thisID = thisID + Math.pow(2, index)
        }
        basic.showNumber(thisID)
        gotID = true

        basic.showIcon(IconNames.Happy)
    }
}

/* when an id is received via radio, send it to Top */
radio.onReceivedNumber(function (receivedNumber: number) {
    let receivedIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let remId = receivedNumber
    for (let i = 9; i >= 0; i--) {
        receivedIDbits[i] = Math.floor(remId / Math.pow(2, i))
        remId = remId % Math.pow(2, i)
    }
    pins.digitalWritePin(DigitalPin.P1, 1)
    basic.pause(100)
    for (let index = 0; index <= 9; index++) {
        pins.digitalWritePin(DigitalPin.P1, receivedIDbits[index])
        basic.pause(100)
    }
    pins.digitalWritePin(DigitalPin.P1, 0)
})

/* broadcast own id periodically */

while (true) {
    basic.pause(1000)
    radio.sendNumber(thisID)
}

