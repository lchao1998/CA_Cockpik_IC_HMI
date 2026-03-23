#include "adasdatamodel.h"
#include "sm_adas.hpp"
#include <QDebug>

struct ObstacleInfo
{
    int x;
    int y;
    const char* url;
};

#define MAX_TYPE 7
#define MAX_RANGE_LEVEL 3
#define BICYCLE_INDEX 1
#define BUS_INDEX 4
#define CAR_INDEX 7
#define MOTORCYCLE_INDEX 10
#define PERSON_INDEX 13
#define TRUCK_INDEX 16
#define UNKOWN_INDEX 19

const struct ObstacleInfo obstacles[MAX_TYPE*MAX_RANGE_LEVEL+1]= {
    {0, 0, ""},
    {936, 242, "../images/adas/bicycle1.png"}, //bicycle <30
    {938, 240, "../images/adas/bicycle2.png"}, //bicycle <80
    {942, 235, "../images/adas/bicycle3.png"}, //bicycle <180
    {905, 210, "../images/adas/bus1.png"}, //bus < 30
    {918, 235, "../images/adas/bus2.png"}, //bus < 80
    {927, 230, "../images/adas/bus3.png"}, //bus < 180
    {920, 270, "../images/adas/car1.png"}, //car < 30
    {929, 276, "../images/adas/car2.png"}, //car < 80
    {935, 259, "../images/adas/car3.png"}, //car < 180
    {936, 252, "../images/adas/motorcycle1.png"}, //motorcycle < 30
    {942, 254, "../images/adas/motorcycle2.png"}, //motorcycle < 80
    {944, 244, "../images/adas/motorcycle3.png"}, //motorcycle < 180
    {928, 264, "../images/adas/person1.png"}, //person < 30
    {932, 262, "../images/adas/person2.png"}, //person < 80
    {942, 254, "../images/adas/person3.png"}, //person < 180
    {912, 218, "../images/adas/truck1.png"}, //truck < 30
    {920, 226, "../images/adas/truck2.png"}, //truck < 80
    {934, 226, "../images/adas/truck3.png"}, //truck < 180
    {920, 288, "../images/adas/unkown1.png"}, //unkown < 30
    {932, 288, "../images/adas/unkown2.png"}, //unkown < 80
    {938, 270, "../images/adas/unkown3.png"} //unkown < 180
};

AdasDataModel::AdasDataModel(int updateInterval, QObject *parent)
    : DataModel{updateInterval, parent},
        m_index(0)
{
    updateIndex();
}

void AdasDataModel::updateData()
{
    if (Adas_ACC_ACCTargetLngRange.isModified() || Adas_ACC_ACCTargetType.isModified()) {
        updateIndex();
        emit adas_obstacle_onChanged();
        emit adas_obstacle_xChanged();
        emit adas_obstacle_yChanged();
        emit adas_obstacle_imageChanged();
    }
}

DATA_PROPERTY_IMPLEMENT(AdasDataModel, adas_obstacle_on, bool)
{
    qDebug() << "AdasDataModel: adas_obstacle_on = " << (bool)(Adas_ACC_ACCTargetType.getValue() != 0);
    return Adas_ACC_ACCTargetType.getValue() != 0;
}

DATA_PROPERTY_IMPLEMENT(AdasDataModel, adas_obstacle_x, int)
{
    qDebug() << "AdasDataModel: adas_obstacle_x = " << obstacles[m_index].x;
    return obstacles[m_index].x;
}

DATA_PROPERTY_IMPLEMENT(AdasDataModel, adas_obstacle_y, int)
{
    qDebug() << "AdasDataModel: adas_obstacle_y = " << obstacles[m_index].y;
    return obstacles[m_index].y;
}

DATA_PROPERTY_IMPLEMENT(AdasDataModel, adas_obstacle_image, QString)
{
    qDebug() << "AdasDataModel: adas_obstacle_image = " << QString(obstacles[m_index].url);
    return QString(obstacles[m_index].url);
}

void AdasDataModel::updateIndex()
{
    unsigned int type = Adas_ACC_ACCTargetType.getValue();
    unsigned int range = Adas_ACC_ACCTargetLngRange.getValue();
    qDebug() << "AdasDataModel: Adas_ACC_ACCTargetType = " << type << ", Adas_ACC_ACCTargetLngRange = " << range;
    switch (type) {
        case 0: { //no display
            m_index = 0;
            break;
        }
        case 1: { //car
            m_index = CAR_INDEX;
            if (range   > 0 && range <= 3) {
                m_index += range - 1;
            }
            break;
        }
        case 2: { //motorcycle
            m_index = MOTORCYCLE_INDEX;
            if (range > 0 && range <= 3) {
                m_index += range - 1;
            }
            break;
        }
        case 3: { //person
            m_index = PERSON_INDEX;
            if (range > 0 && range <= 3) {
                m_index += range - 1;
            }
            break;
        }
        case 4: { //bicycle
            m_index = BICYCLE_INDEX;
            if (range > 0 && range <= 3) {
                m_index += range - 1;
            }
            break;
        }
        case 5: { //bus
            m_index = BUS_INDEX;
            if (range > 0 && range <= 3) {
                m_index += range - 1;
            }
            break;
        }
        case 7: { //truck
            m_index = TRUCK_INDEX;
            if (range > 0 && range <= 3) {
                m_index += range - 1;
            }
            break;
        }
        default: { //unkown
            m_index = UNKOWN_INDEX;
            if (range > 0 && range <= 3) {
                m_index += range - 1;
            }
            break;
        }
    }
}
