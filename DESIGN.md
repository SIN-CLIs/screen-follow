# DESIGN.md — screen-follow

## Warum zentraler Event-Bus?
Nur EIN CGEventTap pro Event-Typ erlaubt. Der Bus sammelt und verteilt via Combine.

## Warum Combine?
Natives Apple-Framework, minimaler Overhead, keine Drittanbieter.

## Warum Lock-Datei statt XPC?
Einfach, atomar, keine Hintergrunddienste nötig.

## Overlay-Design
Transparente `.floating`-Fenster mit `allowsHitTesting(false)`. Klicks gehen durch. Im Video sichtbar.

## CLI-Design
Kein `ArgumentParser` → null Dependencies. Manuelles Parsing für die wenigen Befehle.
