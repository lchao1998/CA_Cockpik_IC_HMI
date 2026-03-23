/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Quick Studio Components.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "app_environment.h"
#include "import_qml_plugins.h"

#if defined(WINDOWS) || defined(SIMULATION)
#include "win/gaugedatamodel.h"
#include "win/telltaledatamodel.h"
#include "win/warningdatamodel.h"
#include "win/tripcomputerdatamodel.h"
#include "win/statusdatamodel.h"
#include "win/adasdatamodel.h"
#else
#include "gaugedatamodel.h"
#include "telltaledatamodel.h"
#include "warningdatamodel.h"
#include "tripcomputerdatamodel.h"
#include "statusdatamodel.h"
#include "adasdatamodel.h"
#endif

//#include "fpslabel.h"

int main(int argc, char *argv[])
{
    set_qt_environment();

    QGuiApplication app(argc, argv);
    GaugeDataModel gaugedatamodel;
    TelltaleDataModel telltaledatamodel;
    WarningDataModel warningdatamodel;
    TripComputerDataModel tripcomputerdatamodel;
    StatusDataModel statusdatamodel;
    AdasDataModel adasdatamodel;

//    qmlRegisterType<FPSLabel>("FPSMonitor", 1, 0, "FPSLabel");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:Main/main.qml"_qs);
    QObject::connect(
                &engine, &QQmlApplicationEngine::objectCreated, &app,
                [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");
    engine.rootContext()->setContextProperty("gaugedatamodel", &gaugedatamodel);
    engine.rootContext()->setContextProperty("telltaledatamodel", &telltaledatamodel);
    engine.rootContext()->setContextProperty("warningdatamodel", &warningdatamodel);
    engine.rootContext()->setContextProperty("tripcomputerdatamodel", &tripcomputerdatamodel);
    engine.rootContext()->setContextProperty("statusdatamodel", &statusdatamodel);
    engine.rootContext()->setContextProperty("adasdatamodel", &adasdatamodel);

    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
