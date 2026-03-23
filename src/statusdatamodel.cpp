#include "statusdatamodel.h"
#include "sm_interaction_status.hpp"
#include "sm_adas.hpp"
#include <QDebug>

StatusDataModel::StatusDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent}
{
}

void StatusDataModel::updateData()
{
    if (interaction_status_Window_Status.isModified()) {
        qDebug() << "StatusDataModel: status_tripcomputer_menuChanged";
        qDebug() << "StatusDataModel: status_adas_statusChanged";
        emit status_tripcomputer_menuChanged();
        emit status_adas_statusChanged();
        emit status_navi_statusChanged();
    } else {
        if (interaction_status_Menu_Status.isModified()) {
            qDebug() << "StatusDataModel: status_tripcomputer_menuChanged";
            emit status_tripcomputer_menuChanged();
        }
        if (Adas_ACC_VehicleAnimationStatus.isModified()) {
            qDebug() << "StatusDataModel: status_adas_statusChanged";
            emit status_adas_statusChanged();
        }
    }
}

DATA_PROPERTY_IMPLEMENT(StatusDataModel, status_tripcomputer_menu, QString)
{
    QString status;
    if (interaction_status_Window_Status.getValue() == 0) {
        switch (interaction_status_Menu_Status.getValue()) {
            case 1: {
                status = "State1";
                break;
            }
            case 2: {
                status = "State2";
                break;
            }
            case 3: {
                status = "State3";
                break;
            }
            default: {
                status = "default";
                break;
            }
        }
    } else {
        status = "default";
    }

    qDebug() << "StatusDataModel: status_tripcomputer_menu = " << status << ", interaction_status_Window_Status = " << interaction_status_Window_Status.getValue();
    return status;
}

DATA_PROPERTY_IMPLEMENT(StatusDataModel, status_adas_status, QString)
{
    QString status;
    if (interaction_status_Window_Status.getValue() == 1) {
        switch (Adas_ACC_VehicleAnimationStatus.getValue()) {
            case 0: {
                status = "static";
                break;
            }
            case 1: {
                status = "forward";
                break;
            }
            case 2: {
                status = "toright";
                break;
            }
            case 3: {
                status = "toleft";
                break;
            }
            default: {
                status = "default";
                break;
            }
        }
    } else {
        status = "default";
    }

    qDebug() << "StatusDataModel: status_adas_status = " << status << ", interaction_status_Window_Status = " << interaction_status_Window_Status.getValue();
    return status;
}

DATA_PROPERTY_IMPLEMENT(StatusDataModel, status_navi_status, bool)
{
    bool ret = (interaction_status_Window_Status.getValue() == 2);
    qDebug() << "status_navi_status = " << ret;
    return ret;
}