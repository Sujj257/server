import { Body, Controller, Post, Req } from '@nestjs/common';
import { ManageAppService } from './manage_app.service';
import { TimeDto } from './dto/get_time_dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { ManageTicketDto } from './dto/ticket_manage_dto';


@ApiBearerAuth()
@ApiTags('Manage App')
@Controller('manageapp')
export class ManageAppController {
    constructor(private readonly manageAppService: ManageAppService) { }

    @Post('time')
    timeManage(@Body() body: TimeDto, @Req() req) {
        return this.manageAppService.timeManage(body, req.sessionpayload);
    }

    @Post('ticket')
    ticketManage(@Body() body: ManageTicketDto, @Req() req) {
        
        return this.manageAppService.ticketManage(body, req.sessionpayload);
    }
}
