

bluetooth.onBluetoothConnected(function () {
    connected = true

})

bluetooth.onBluetoothDisconnected(function () {
    connected = false
})


bluetooth.startUartService()
let connected = false
let thisID = 0
let delimiter = serial.delimiters(Delimiters.Dollar)

let receivedID = 0
let receivedIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

basic.showLeds(`
    # . . . #
    # . . . #
    # . . . #
    # # # # #
    # # # # #
    `)
pins.digitalWritePin(DigitalPin.P1, 0)

/* TODO: get id via bluetooth here */
while (!connected) {
    basic.showString(control.deviceName())
}
thisID = parseInt(bluetooth.uartReadUntil(delimiter))
basic.showNumber(thisID)

let thisIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
let remId = thisID
for (let i = 9; i >= 0; i--) {
    thisIDbits[i] = Math.floor(remId / Math.pow(2, i))
    remId = remId % Math.pow(2, i)
}


basic.showIcon(IconNames.Happy)

/* id is sent to Bot for broadcasting */
pins.digitalWritePin(DigitalPin.P1, 1)
basic.pause(100)

for (let index = 0; index <= 9; index++) {
    pins.digitalWritePin(DigitalPin.P1, thisIDbits[index])
    basic.pause(100)
}
pins.digitalWritePin(DigitalPin.P1, 0)


/* polling for ids from Bot */

while (true) {
    basic.pause(50)
    if (pins.digitalReadPin(DigitalPin.P2) == 1) {
        receivedID = 0
        receivedIDbits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        basic.pause(100)
        for (let index = 0; index <= 9; index++) {
            basic.pause(10)
            receivedIDbits[index] = pins.digitalReadPin(DigitalPin.P2)
            basic.pause(90)
        }
        for (let index = 0; index <= 9; index++) {
            if (receivedIDbits[index] > 0)
                receivedID = receivedID + Math.pow(2, index)
        }

        basic.showNumber(receivedID)

        /* TODO: Stack received id to send later via Bluetooth or send instantly */
        bluetooth.uartWriteString("" + convertToText(receivedID) + "$")


        basic.showIcon(IconNames.Happy)
    }
}

