Return-Path: <SRS0=e5UK=OX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07668C43387
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440AC206C0
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 18:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeLNSLo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:11:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:37540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729752AbeLNSLo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Dec 2018 13:11:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DE82AE7A;
        Fri, 14 Dec 2018 18:11:42 +0000 (UTC)
From:   Ignaz Forster <iforster@suse.de>
Subject: Bug: Persisting O_TMPFILE with IMA
To:     zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, Fabian Vogt <fvogt@suse.de>
Message-ID: <884653bf-2e25-b78f-2dc7-51c5a57d4b51@suse.de>
Date:   Fri, 14 Dec 2018 19:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

persisting files opened with O_TMPFILE doesn't seem to work on IMA as 
expected: The IMA xattr won't be written. This makes it impossible to 
access the file later.
The following example application, based on the O_TMPFILE example from
	man 2 open
will demonstrate this:


#include <fcntl.h>
#include <unistd.h>
#include <linux/limits.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
	char path[PATH_MAX];
	int fd = open("/tmp", __O_TMPFILE | O_RDWR, S_IRUSR | S_IWUSR);
	write(fd, "test", 4);
	snprintf(path, PATH_MAX, "/proc/self/fd/%d", fd);
	linkat(AT_FDCWD, path, AT_FDCWD, "/tmp/tmpfile_persisted.txt",
			AT_SYMLINK_FOLLOW);
}


(/tmp should not be a tmpfs of course; change to paths to a supported 
file system if necessary.)

This was discovered when trying to understand why IMA is failing on 
overlayfs during truncated copy_up operations (see thread "PROBLEM: IMA 
xattrs not written on overlayfs" from September / October), though this 
is probably a different problem.

Ignaz
