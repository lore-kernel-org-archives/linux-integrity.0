Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751970AbeCNOhb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 10:37:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EEahIQ111047
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 10:37:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gq5c68y5m-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 10:37:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 10:37:29 -0400
Subject: Re: [PATCH v3 4/4] fuse: define the filesystem as untrusted
To: "Serge E. Hallyn" <serge@hallyn.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
 <20180312192950.GE29878@mail.hallyn.com>
 <1fd04e0e-37ab-329c-c75d-d349a3b2f136@linux.vnet.ibm.com>
 <20180314142701.GA6497@mail.hallyn.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 10:37:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180314142701.GA6497@mail.hallyn.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0bb667b0-96c6-55e4-b2ea-17b77864df2e@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 03/14/2018 10:27 AM, Serge E. Hallyn wrote:
> Quoting Stefan Berger (stefanb@linux.vnet.ibm.com):
>> On 03/12/2018 03:29 PM, Serge E. Hallyn wrote:
>>> Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
>>>> Files on FUSE can change at any point in time without IMA being able
>>>> to detect it.  The file data read for the file signature verification
>>>> could be totally different from what is subsequently read, making the
>>>> signature verification useless.
>>>>
>>>> FUSE can be mounted by unprivileged users either today with fusermount
>>>> installed with setuid, or soon with the upcoming patches to allow FUSE
>>>> mounts in a non-init user namespace.
>>>>
>>>> This patch sets the SB_I_IMA_UNVERIFIABLE_SIGNATURE flag and when
>>>> appropriate sets the SB_I_UNTRUSTED_MOUNTER flag.
>>>>
>>>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>>>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>>>> Cc: Seth Forshee <seth.forshee@canonical.com>
>>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>>>> Cc: Dongsu Park <dongsu@kinvolk.io>
>>>> Cc: Alban Crequy <alban@kinvolk.io>
>>>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>>> Acked-by: Serge Hallyn <serge@hallyn.com>
>>>
>>> Of course when IMA namespacing hits, you'll want to compare the
>>> sb->s_user_ns to the (~handwaving~) user_ns owning the ima ns
>>> right?
>> I suppose this would be the only way to enable 'trusted mounters'
>> within IMA namespaces. Maybe there could be an additional capability
>> gate that would allow one to be a 'trusted mounter' then?
> Wouldn't CAP_SYS_ADMIN to the ima_ns->user_ns suffice?
>
> I personally think CAP_INTEGRITY would make sense, but right
> now CAP_SYS_ADMIN seems to suffice so it wouldn't make sense to
> raise the bar there unless we raise it for all of IMA configuration.

So for IMA namespacing we may want to avoid CAP_SYS_ADMIN and introduce 
one or more capabilities to:

- set security xattrs from inside the container (when building the 
container for example, maybe also during runtime)
- access IMA's securityfs entries 
(https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_fs.c#L391) 
from inside the container for reading/writing the policy  (during run-time)
- then possibly mounting a trusted filesystem via fuse

    Stefan

>
> -serge
>
