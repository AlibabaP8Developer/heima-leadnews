package com.heima.wemedia.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.heima.file.service.FileStorageService;
import com.heima.model.common.dtos.PageResponseResult;
import com.heima.model.common.dtos.ResponseResult;
import com.heima.model.common.enums.AppHttpCodeEnum;
import com.heima.model.wemedia.dtos.WmMaterialDto;
import com.heima.model.wemedia.pojos.WmMaterial;
import com.heima.utils.thread.WmThreadLocalUtil;
import com.heima.wemedia.mapper.WmMaterialMapper;
import com.heima.wemedia.service.WmMaterialService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;


@Slf4j
@Service
@Transactional
public class WmMaterialServiceImpl extends ServiceImpl<WmMaterialMapper, WmMaterial> implements WmMaterialService {

    @Autowired
    private FileStorageService fileStorageService;

    @Override
    public ResponseResult uploadPicture(MultipartFile multipartFile) {
        // 1 检查参数
        if (multipartFile.isEmpty() || multipartFile.getSize() == 0) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }
        // 2 上传图片到minio中
        String fileName = UUID.randomUUID().toString().replace("-", "");
        // 文件名
        String originalFilename = multipartFile.getOriginalFilename();
        // 后缀名
        String postfix = originalFilename.substring(originalFilename.lastIndexOf("."));
        String newFileName = fileName + postfix;
        String fileId = "";
        try {
            fileId = fileStorageService.uploadImgFile("", newFileName, multipartFile.getInputStream());
            log.debug("上传图片到minio, fileId:{}", fileId);
        } catch (IOException e) {
            e.printStackTrace();
            log.error("WmMaterialServiceImpl---上传图片到minio失败");
        }

        // 3 保存数据库
        WmMaterial wmMaterial = new WmMaterial();
        wmMaterial.setUserId(WmThreadLocalUtil.getUser().getId());
        wmMaterial.setUrl(fileId);
        wmMaterial.setIsCollection((short) 0);
        wmMaterial.setCreatedTime(LocalDateTime.now());
        this.save(wmMaterial);
        // 4 返回结果
        return ResponseResult.okResult(wmMaterial);
    }

    @Override
    public ResponseResult findList(WmMaterialDto dto) {
        //1.检查参数
        dto.checkParam();
        //2.分页查询
        IPage<WmMaterial> page = new Page<WmMaterial>(dto.getPage(), dto.getSize());
        LambdaQueryWrapper<WmMaterial> queryWrapper = new LambdaQueryWrapper<>();
        // 是否收藏
        if (dto.getIsCollection() != null && dto.getIsCollection() == 1) {
            queryWrapper.eq(WmMaterial::getIsCollection, dto.getIsCollection());
        }
        // 按照用户查询
        queryWrapper.eq(WmMaterial::getUserId, WmThreadLocalUtil.getUser().getId());
        // 倒序查询
        queryWrapper.orderByDesc(WmMaterial::getCreatedTime);
        page = page(page, queryWrapper);

        // 返回结果
        ResponseResult responseResult = new PageResponseResult(dto.getPage(), dto.getSize(), (int)page.getTotal());
        responseResult.setData(page.getRecords());
        return responseResult;
    }
}
