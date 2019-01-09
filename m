Return-Path: <SRS0=d4Rs=PR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C270C43387
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5358720883
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jan 2019 01:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfcyUOxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfAIBsy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:48:54 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36812 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbfAIBsx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jan 2019 20:48:53 -0500
Received: by mail-pl1-f201.google.com with SMTP id e68so3252105plb.3
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jan 2019 17:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bX86RtkRUqqh9QbkFoIBW3Kdcs+YbtsHMlnC8iO3lF4=;
        b=HfcyUOxSajcZuWAvJHCH3lIyuobDYZWgczV9qOb6ircMCd2Ub42UbebqcWJSECeWjz
         Zb9GBOzm4UbeDjcf3rI4Y1LSwBOqMl3SoJXBdEIfXtoGBTjOLFv2R08AWzECZB8qjGqs
         BLtydTXhNvRuDujyhJHy6uMHfeeEwu8pM/oxKb6unkvzeqL0UL7RFw/JhieaJCBPCMvA
         9GagSUuyAaN2GqB8oBK5qZuXtAG3NAjbCqSjlD9PdDBrNMTRw2Q08vN+Oy5lWUWFyL94
         854qcnPXXvflOfJ41yLqKHM7duYQRzrcjA6qOMe8TKkycd4AWTJlNrb8lbAXRV5x1nYE
         xnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bX86RtkRUqqh9QbkFoIBW3Kdcs+YbtsHMlnC8iO3lF4=;
        b=cvZr7e8E4ZnU2YUsnRO3eHZ/PQgE8k+rBruUFwlBKeuFTpN1z+y33EoqY1CqCPOhYo
         FBjYs7CgRGg9pqO9aT+gkMFgXdpSKbTR90pXHIHmcuue+ZKKKWFBmjtmR+0Y448rn11d
         jbTtfw4kMl6OsMZ1P65AaslbAIvGJ5cUF7hYfsgt+AjVPbE66aOEmISW/r9BLKdM+AOn
         MyUwW+KbD6uL/aHlX8dH+EILF6Js7t24kgtIzAdjjeSaQvru8arEiribi9bwKPRsN+ib
         oBRBEFbpbrqx8OrzTClYtqB+ZSadGRFU+CqesRQnnBagxOiTUkpibUR9ceJzWKv2EoiI
         27Gg==
X-Gm-Message-State: AJcUukf0uRl+c3hI0fgAfVOB3vLnwJN1bA/EjP9gFBxDifCukLbNHbOT
        2V6JwDe1GWDNE7ElGs3vx9eIOAmzq/kjq2uiC2ULWebqihVhsbip4WBpAQK2LbIk8FVY8SaekpO
        aO2G9uZDjjhys51uh3hG6GYE90aQbgkbSE/YsnkqDWivfk8LBOEIcgUEuX/rh6MbgKkv6f7L9Bm
        /t4LE9X/DYbT5T/P7nPfY=
X-Google-Smtp-Source: ALg8bN4XdRk4qOQ30K6Y5hJre768ufk8/GVAKj6stLseF251NxezXeD68GaeglnEArQnTr6H7RbbF33BTdqD2Bz3giL0wA==
X-Received: by 2002:a63:1f09:: with SMTP id f9mr1879701pgf.84.1546998533182;
 Tue, 08 Jan 2019 17:48:53 -0800 (PST)
Date:   Tue,  8 Jan 2019 17:48:42 -0800
Message-Id: <20190109014847.39980-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: Add support for the TCG2 event log on UEFI systems
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are several complexities associated with handling the crypto-agile
log format from TPM2 systems on UEFI platforms. The first is that each
log entry may be of variable length, necessitating parsing the log
in-kernel to determine its length. The second is that the log is kept in
boot services memory (which is reclaimed by the OS after
ExitBootServices() is called), but ExitBootServices() may introduce
additional log entries. These additional log entries are added to a
separate log which should then be merged into the initial log.

This patchset makes the existing support for calculating TPM events more
general (in order to allow it to be used from the EFI boot stub), adds
support for copying up crypto agile logs from the boot environment to
the running kernel and adds support for merging the final events log
into the initial events log.


