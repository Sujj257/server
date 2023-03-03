import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
import { MenuDto } from './dto/menu.dto';
import { SessionPayloadDto } from '../login/dto/jwttoken.dto';

@Injectable()
export class MenuService {
    constructor(private readonly db: DatabaseService) { }

    async GetMenu(payload: MenuDto, sessionpayload: SessionPayloadDto) {
        try {
          
            if (payload.account_id == 'null' && payload.isedit == true) {
                payload.account_id = null;
            } else if (payload.account_id == 'null' && payload.isedit == false) {
                payload.account_id = sessionpayload.account_id;
            } else {
                payload.account_id = parseInt(payload.account_id);
            }
            console.log(payload.account_id);
            var queryResponse = await this.db.executeFunc('select sd_draw($1,$2,$3,$4,$5,$6,$7)', 'sd_draw', [payload.account_id, payload.one_pm,payload.three_pm, payload.six_pm, payload.eight_pm,payload.isedit, sessionpayload.account_id]);
            return queryResponse;
        } catch (error) {
            throw error;
        }
    }
}
